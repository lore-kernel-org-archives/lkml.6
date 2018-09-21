Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76443C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CC82147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gf6yfDKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CC82147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeIUG41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:56:27 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:44590 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388850AbeIUG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537492209; bh=V+yMfFj1ICLwnW5PuD+WMkbCrrB6HKESCNC+Icgaf/8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gf6yfDKxJPu1rZ2y6gK2+YojlfyczXW+uthqlLkKN6xSYlg10W7bzvwTDqz4os3v4MdC0hXuI1aea6Hi/0Edcru99glQInILRWQFDfpcaXDA0jMCmlNlLKBz2X3W60UbtSxtM1PGzzz2I04Dfk2ZN2NGT3If3NomV7EPmg/QGQUauXseUvifY9ajVLZcFs9YmGGjj+TR5+ydeSjFKqAyAlxXlp+eu9V+6jDYfdD5LpEBODx9eqTkApcspnY6y+Zl5h9y4LTBdmVOEUZkDtmn7Bh1Zk1x1PPuYcTr2h3D2ipFwN5dnhMHHxBPWBandjgKJx5ndRb9CFzeso6P9w7M2w==
X-YMail-OSG: UGMaS1EVM1mVg6DvyMK1EmLqsRV4q67ttJ9sWrZ5uHyQVEauIeu434aYn7EOPy5
 oqLn2Re34p1fYuJz43q_7N5IjTs6_MyyPwBBGnzs3lmQV.N.w6rSOnLwgOd.3XOvhOVNIlTu9ioZ
 tpKX8czpQZ2PHhbPeqNAEscTIgeuX.xSNkv5tCEOHXdq1RXrszCSyBTqaWOuCezKLaTeBvvxDNp4
 EEwx0vuQr0Smz.BmgQBZ6Ys7yiL0_cfa2ndli0cR6sUkrFgbTPoU6p97RzPG8O0LEPNKNfqspq1R
 v4BKma2vcj9pOQDhYSLN0LaDvru97nrp3oS_C6SnvsbibRpqSOwRO8SxixDuueFgFd_HZ0UElvfM
 exSCnLjbt33veUseBCKAfIiUaK3jg5gv5AvqlLojeCa4Q.Wpv4Wtai3NSmtjT6hfA1kf2o3mvQJt
 DQffE4m3OVNGicI3GcWSXlxi5vLJpCKIoRR6vuKNvSf.Q8x9DRDvq8eUSZnEO4W8ZvaSg90RiGXj
 WP0dE4HrAPE9CoftZuHz643MbJgLYp58StDXMypnikqaTC2qxhsfENozfIriWRDO_Dof6RN8sSfX
 rEmryex33wHRw_OqBaSyINzFLpymKgg4_uub75TVoP03bNKafD3aLH5tRovmI5FMN2Lmi5_VOpFz
 ZENQ3.9Vsv3Y8wHLEhkPVcTVDCOsJTCWoV.mHNaUfG5qBmXtbViiHS9O2XhfMhFQ1wqzmaOtvubK
 Quj_oyqDtGlmRkQmCaiHgvVt.VsI0Fq7YawbLInHPXoaI42jdWwejNzEmJWvec.eMgeIVWxjlvuJ
 T6JGHsM9CoskjM2hDOROqWSKL2Jwp1tTCKc62V.tHEQ5Ze5uS8nnFDOl7Gfb4OLrTF4DYffr3I.b
 Kc_ZHFmugWsa0wOsQtkeObK1g.tsQpifu9imENOJKjk0k7UV4ibUOiKM3HRlNA60Ltupzfj66qnc
 7U6ZMRFt.48fxOdyuRl2O1Z1nFLYdvtvHZVuC3O6AszZSNQnyrOF_rUz0XDvt.whyX0DbeWgpz3T
 iQG._ctbMREMuySrgojnGsHzgYtJ.y9_r
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 01:10:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6b2b85509dd71181d40a6ba179a93e22;
          Fri, 21 Sep 2018 01:10:07 +0000 (UTC)
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
 <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 18:10:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 5:45 PM, Kees Cook wrote:
> On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>>  config LSM_ORDER
>>>       string "Default initialization order of builtin LSMs"
>>> -     default "yama,loadpin,integrity"
>>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>> If I want to compile all the major modules into my kernel and use
>> AppArmor by default would I use
>>
>>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>>
>> or
>>
>>         default "yama,loadpin,integrity,apparmor"
> I was expecting the former, but the latter will have the same result.
>
>> When we have "blob-sharing" how could I compile in tomoyo,
>> but exclude it without a boot line option?
> Ooh, yes, this series has no way to do that. Perhaps
> CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
> totally remove LoadPin's CONFIG for this in favor it.

I would generally prefer an optional CONFIG_LSM_ENABLE to
CONFIG_LSM_DISABLE, but I understand the logic behind your
approach. I would be looking for something like

CONFIG LSM_ENABLE
	string "Default set of enabled LSMs"
	default ""

as opposed to

CONFIG LSM_DISABLE
	string "Default set of disabled LSMs"
	default ""

where an empty string is interpreted as "use 'em all" 
in either case.

>> When we have full stacking, how could I compile in selinux
>> but exclude it?
> Yup, same problem. Same suggested solution?
>
> Should lsm.enable/disable= also become a comma-separated list, or
> should I leave it as a multi-instance thing like I have it?

I prefer the multi-instance
	lsm.disable=selinux lsm.disable=yama
to the list
	lsm.disable=selinux,yama

but at this point I don't really care all that much.

