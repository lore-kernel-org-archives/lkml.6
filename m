Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BD208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pjOAC86l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6BD208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbeIXXUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:20:07 -0400
Received: from sonic316-14.consmr.mail.gq1.yahoo.com ([98.137.69.38]:34047
        "EHLO sonic316-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729619AbeIXXUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537809416; bh=Efwg4nY3KVoKRNjy7hoQI59gRRUnL4c6O3OkmHiVU6s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pjOAC86l+EBQj8/5TL9mbk37ynhFgK8NnQQwr6uJLhnZH/vhxKEAso+1H1O7n3dSHSml2A+BrdzHTFFp9giz2Pl7qzbiNgyrcjTxSgnT76kPLiLLEHtcFVFemTD622JQAQBILp9PgLkK3XI1n81c2OcKjo3HI5+0hHErq0F8ks9p8X+DFgCP4xEa2UPBO7BzRdr5inGwOKpmaAQ3uP9l4DyvUmxpDoK/0S+CAxl0gVGRRubmSxuvKoTLgWYLNA+sl8gZ7ohFDNMTH/HrYg7zBEbEBUwzlcPHVSabe/ncMd2DZ8zc1j/aNiKvuch0ILxJR9aB1fpcZBGlxgNKe+PuEw==
X-YMail-OSG: i_yIEFcVM1k7DgUKL.f0rsrh.3ZIi3PtHiWTC.Eb_lRUAdmHDJLfN3eBFxcJagx
 RKWAV_VtTupOOnFfqToqYcsWD76jk0JcJ0kGiudqxGttAmr1HdpVpksri65P3j7P6.vebOTW32XF
 um15qH.X.cn6tMKabXoEqJWcN7S.FVKqafFxsiTl3d5KuWUHcAi2HJv03oDMARYpRBwlK_zcq79.
 qAWUAN3RE_iq999yRUPsFSWD.oyaI_OuKIjt0JX.bIXqmT_J4_cFBWEGsZ0KeacV_X9ow_haJ01M
 Wp_lVstj7o3NXjnmGXF6miBiy.W0bmzBH4g23F8w9.c_uAF8W3NMetdLu5otWEiO62iPCPpERzg4
 jfh4Ik3vrAUnAtqbZj57ZaU6T5.u5WlQmeaTPh624SHEPyFDQqqTEcEwFtz1Ed_3xw.DtdocwLU0
 D_hLeIhwGaKq5psuifxByjcaEqmHAK.Kcr.m5K5P3BJV449Lt_mPvr7d8xfCixZluya.J6_hhhmP
 YIaLa2P.YSuv9ATnTKjbd2mZnzgndyWDkH7.sxRcthdnthU1RXbi_Lmx8vHI_UkfxJiMxwTKK9WK
 .5J7wxEVU22AYdafbraJBpvnxyYh919pxMURBJyIcCsP1LyOVbpX9bOb4Xpsq6Y.rbVBbffoOYOT
 aKDQdaV97UquTm0KWg7nc.IPDzsqNumyvXcJ__QzpTdikZy_st6svvq8NPRo.KA83Ka2w4OzhWo.
 Q1eqmcWG8o98XQlxZjPibeURQ29Kn.og02TAUuSF1VpjDcfxMPqoEqws9RYiy6whYpV7djGSJIsf
 UGkvtdTeeCqRHe0rg2kuXvo_JOL1x8hla5.buB_Bgy_g.pfudyCKAKzwIlNIJv2UaiLFrQdWkg5C
 XVNLXOUCT5tnT6N8yTRPBg7fGLqqu3GEI_Cl0Wt.PYWjpqURu.OAk8TP3JF2pcw._4OcROuWMEvh
 8dG.iKlCEBoM2AVBOgFgjhy1AsZuoorcrKxQ9c_QS0WmpNVImEUWF4tL74ojrE7g.gprBr.IJNev
 F.OhbJhh5Xggji6x93EskDKs3BX7P
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Sep 2018 17:16:56 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6aff77e11ea6be2f00c39378ed02a5ba;
          Mon, 24 Sep 2018 17:16:53 +0000 (UTC)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
 <da179a76-691e-32f5-9391-c432a72fe37e@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3350edec-c233-9428-73b0-58d582d1e3b9@schaufler-ca.com>
Date:   Mon, 24 Sep 2018 10:16:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <da179a76-691e-32f5-9391-c432a72fe37e@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2018 6:53 PM, Tetsuo Handa wrote:
> On 2018/09/24 2:09, Casey Schaufler wrote:
>>>   Since all free hooks are called when one of init hooks failed, each
>>>   free hook needs to check whether init hook was called. An example is
>>>   inode_free_security() in security/selinux/hooks.c (but not addressed in
>>>   this patch).
>> I *think* that selinux_inode_free_security() is safe in this
>> case because the blob will be zeroed, hence isec->list will
>> be NULL.
>>
> OK.
>
>>>   This patchset might fatally prevent LKM-based LSM modules, for LKM-based
>>>   LSMs cannot count on lsm_*_alloc() because size for lsm_*_alloc() cannot
>>>   be updated upon loading LKM-based LSMs.
>> LKM based security modules will require dynamically sized blobs.
>> These can be added to the scheme used here. Each blob would get a
>> header identifying the modules for which it contains data. When an
>> LKM is registered if has to declare it's blob space requirements
>> and gets back the offsets. All alloc operations have to put their
>> marks in the header. All LKM blob users have to check that the blob
>> they are looking at has the required data.
>>
>> module_cred(struct cred *cred) {
>> 	return cred->security + module_blob_sizes.lbs_cred;
>> }
>>
>> becomes
>>
>> module_cred(struct cred *cred) {
>> 	if (blob_includes(module_id))
>> 		return cred->security + module_blob_sizes.lbs_cred;
>> 	return NULL;
>> }
>>
>> and the calling code needs to accept a NULL return.
> Not all of LKM-based LSMs use security blobs. And some of LKM-based LSMs
> might use security blobs for only a few objects. For example, AKARI uses
> inode security blob for remembering whether source address/port of an
> accept()ed socket was already checked, only during accept() operation and
> first socket operation on the accept()ed socket. Thus, there is no need
> to waste memory by assigning blobs for all inode objects.

The first question is why use an inode blob? Shouldn't you
be using a socket blob for this socket based information?

If you only want information part of the time you can declare
a pointer sized blob and manage what hangs off that as you will.
I personally think that the added complexity of conditional
blob management is more pain than it's worth, but if you want
a really big blob, but only on occasion, I could see doing it.

>> Blobs can never get smaller because readjusting the offsets
>> isn't going to work, so unloading an LKM security module isn't
>> going to be as complete as you might like. There may be a way
>> around this if you unload all the LKM modules, but that's a
>> special case and there may be dragon lurking in the mist.
> If LKM-based LSMs who want to use security blobs have to check for
> NULL return, they might choose "not using infrastructure managed
> security blobs" and "using locally hashed blobs associated with
> object's address" (like AKARI does).

I can't see how a check for NULL could possibly be a bigger
hassle than doing your own locally hashed blobs.

>
>>>  If security_file_free() is called
>>>   regardless of whether lsm_file_cache is defined, LKM-based LSMs can be
>>>   loaded using current behavior (apart from the fact that legitimate
>>>   interface for appending to security_hook_heads is currently missing).
>>>   How do you plan to handle LKM-based LSMs?
>> My position all along has been that I don't plan to handle LKM
>> based LSMs, but that I won't do anything to prevent someone else
>> from adding them later. I believe that I've done that. Several
>> designs, including a separate list for dynamically loaded modules
>> have been proposed. I think some of those would work.
> Though AKARI is not using security_file_free(), some of LKM-based LSMs
> might want to use it. If file_free_security hook is called unconditionally,
> such LKM-based LSMs can be registered/unregistered, without worrying about
> inability to shrink sizes for blobs.

The infrastructure wouldn't call unregistered hooks, so any module
that allocates additional memory attached to a blob is going to have
to deal with freeing that when it unregisters. Aside from that unregistration
should be a (not so) small matter of locking.

>
>>> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>>>  {
>>>  	void *blob;
>>>  
>>> +	call_void_hook(file_free_security, file);
>>> +
>>>  	if (!lsm_file_cache)
>>>  		return;
>>>  
>>> -	call_void_hook(file_free_security, file);
>>> -
>> Why does this make sense? If the lsm_file_cache isn't
>> initialized you can't have allocated any file blobs,
>> no module can have initialized a file blob, hence there
>> can be nothing for the module to do.
>>
> For modules (not limited to LKM-based LSMs) which want to use
> file blobs for only a few objects and avoid wasting memory by
> allocating file blobs to all file objects.
>
> Infrastructure based blob management fits well for LSM modules
> which want to assign blobs to all objects (like SELinux). But
> forcing infrastructure based blob management can become a huge
> waste of memory for LSM modules which want to assign blobs to
> only a few objects. Unconditionally calling file_free_security
> hook (as with other hooks) preserves a room for allowing the
> latter type of LSM modules without using infrastructure based
> blob management.

There is a hypothetical issue here, but that would require abuse
of the infrastructure. Having a file_free_security hook that doesn't
free a security blob allocated by file_alloc_security may coincidentaly
be useful, but that's not the intent of the hook.

