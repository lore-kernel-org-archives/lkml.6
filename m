Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4162547-1525035583-2-18410134601772278588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525035582; b=VN+QIJjHKZyrFJSmLxa3vxKWP+6G1XoaIU7K6Ty6yJOG1l3Grw
    W83gGcTakYg7fC9Wejn/7e5aKeCQEiHasgZdw3PFJcE+V1VU8UgIQaX9ert9kA09
    kK3KKR7jssMBxTM8c6DsyzDtwM2TXkKZou112zzUw5DdM4FeikCIYvlyjW8LWtqY
    N9PJRTlGbO3MBfYGiMP+zZmmDMHefjI/UgVELA/0XRT15cQthua3K94BYBMeI9qg
    55gvustEEsRDJozQMxVnAjTEtjMMs2aSD8tUddIeups77RFjc+9Opkglqrzsn+Oz
    7eFQCpOqvIZaUID+FpMJDfqn2GqnJ5lrsSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525035582; bh=n7Yn0
    9EWcyPIjV1oc1GTitzKMNOEsh4uYRNCw9koFZw=; b=Mzb69bD/nPDEWrTehM3AQ
    XLH196YgpIkuzMe7wnLM+2c33r60Ao1UXAsdGQZoUtjx5v/oY3yixjInKQTEgN2M
    f/vAz04YmT0p9Ym3v7QOPqWQuq6D/NxuhaxRzfhKMbd7gIRDwedSR6ElyQ6p2MuM
    cDQvKpbz0OivjFsQ49NvigVaaYOFg30dHUNnk8UBmfoyJ1SS+2DY+Lr+OvOIlByh
    zYKyhnCViWRyMDkxfsCAlUC2DWqr6f8lfT52TUTOah0MNLC5I3NjjsydZ0fcu00z
    +sc3oRj0XlmbXqBLgFrQ+1sPMonRFqKra2OQHHN9Y7gO1lx7dqeISgqG6+eJx+eR
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=umn.edu header.i=@umn.edu header.b=Zyi4C6bk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=umn.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=umn.edu header.i=@umn.edu header.b=Zyi4C6bk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=umn.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAkYOtPRdK1qzITi0gzLNSaXgTrLbrBkkoRWPenZBt8sqY3o6pTQJFl5tOZx3ErqJk6s6UD4AiWPE0xVJmbdEEc9fXQNkSDZjPPQTFfF+wUAabUfmVUJ
    xP2hSTs7d7bBMPllBGH1/Rds0QgOShSUkjUDf8YXPIKEaUny5f/uAZ0R4RyyaVuCB9Ch70fnpql9hicmdcBLXzJT0VYGuPs3VtiHW+lI1AFn9dRuIXOcMRzJ
    OgR8G1B5SFuFl433MRglew==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=DDOyTI_5AAAA:8 a=LG_k5ukMYymHqRa1agYA:9 a=w4J_xuQoXk52UqfM:21
    a=t2HjkpR08TjEYH9E:21 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpX1JcEbK4T1gALJKo40dx/uYB9/9L1bAMT9jEy6kAlbMwYUjJ65LWTe0RQpXuO8ZA0zIFikUNodl65kFm0FM4=
MIME-Version: 1.0
In-Reply-To: <20180429132058.GB5972@kroah.com>
References: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
 <8E6ADED8-592E-4794-8CAB-913A325B1971@intel.com>
 <20180429132058.GB5972@kroah.com>
From: Wenwen Wang <wang6495@umn.edu>
Date: Sun, 29 Apr 2018 15:58:55 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dPWAsqfQOWzvecHqAHYuhA63_+ya6nOMdPQ7ZaL6JB9w@mail.gmail.com>
Message-ID: <CAAa=b7dPWAsqfQOWzvecHqAHYuhA63_+ya6nOMdPQ7ZaL6JB9w@mail.gmail.com>
Subject: Re: [PATCH] staging: luster: llite: fix a potential missing-check bug
 when copying lumv
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>, "Dilger,
 Andreas" <andreas.dilger@intel.com>, Jeff Layton <jlayton@redhat.com>, "Drokin,
 Oleg" <oleg.drokin@intel.com>, Wenwen Wang <wang6495@umn.edu>,
 "kjlu@umn.edu" <kjlu@umn.edu>, NeilBrown <neilb@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ben Evans <bevans@cray.com>,
 "lustre-devel@lists.lustre.org" <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 8:20 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Apr 28, 2018 at 04:04:25PM +0000, Dilger, Andreas wrote:
>> On Apr 27, 2018, at 17:45, Wenwen Wang <wang6495@umn.edu> wrote:
>> > [PATCH] staging: luster: llite: fix potential missing-check bug when copying lumv
>>
>> (typo) s/luster/lustre/
>>
>> > In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
>> > using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
>> > LOV_USER_MAGIV_V3, lumv3 will be modified by the second copy from the user
>>
>> (typo) s/MAGIV/MAGIC/
>>
>> > space. The second copy is necessary, because the two versions (i.e.,
>> > lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
>> > However, given that the user data resides in the user space, a malicious
>> > user-space process can race to change the data between the two copies. By
>> > doing so, the attacker can provide a data with an inconsistent version,
>> > e.g., v1 version + v3 data. This can lead to logical errors in the
>> > following execution in ll_dir_setstripe(), which performs different actions
>> > according to the version specified by the field lmm_magic.
>>
>> This isn't a serious bug in the end.  The LOV_USER_MAGIC_V3 check just copies
>> a bit more data from userspace (the lmm_pool field).  It would be more of a
>> problem if the reverse was possible (copy smaller V1 buffer, but change the
>> magic to LOV_USER_MAGIC_V3 afterward), but this isn't possible since the second
>> copy is not done if there is a V1 magic.  If the user changes from V3 magic
>> to V1 in a racy manner it means less data will be used than copied, which
>> is harmless.
>>
>> > This patch rechecks the version field lmm_magic in the second copy.  If the
>> > version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
>> > returned: -EINVAL.
>>
>> This isn't a bad idea in any case, since it verifies the data copied from
>> userspace is still valid.
>
> So you agree with this patch?  Or do not?
>
> confused,
>
> greg k-h

It is worth fixing this bug, since it offers an opportunity for adversaries
to provide inconsistent user data. In addition to the unwanted version
LOV_USER_MAGIC_V1, a malicious user can also use the version
LMV_USER_MAGIC, which is also unexpected but allowed in the function
ll_dir_setstripe(). These inconsistent data can cause potential logical
errors in the following execution. Hence it is necessary to re-verify the
data copied from userspace.

Thanks!
Wenwen
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
