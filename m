Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525128272-2-15072720010586309694
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
    1525128271; b=bfvysI4JhN2mGbW5fS+cPH2YV3TZLltRiA1CiKIBEhnNSRXJS/
    R7xPR8LtVwWznVhrUCBKz+Zg1XVVpVc/RbcBz3i+hsqJ5tGpPjVK+rT8ixDCXiv3
    dDjThEpxK5b3AGGsN2pCVIIoGntuuWShIGqrNPJUF66ZMMFb28P1DFPQvbXpyJws
    CoRudFqrMdkGZti4mONumnO9baNGohXm4MMlN+0rqb8sANz/TvnPC1Y86dJeww/G
    bwRUSpj5Ree+BwAr59XOUBz/r6JBhptv9xjTj3tKvrC2ezLMEHUknFNDBAXN5lWm
    uc/tnQAx+rg5DNTiD0Y77B1Buj6/9w8VvfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525128271; bh=E9HRN
    P4023n/6OFIdmEOIO9xCTDR/YWPkv/j1yi9sqs=; b=jwJgwnJGDJVlSR7EAvxNo
    z6OIpem/NzuYHtlJ0DDEYeqtksXdrPqZsf7L6L2kFGBez8Rdldh1TTRORbGbVbHW
    DdNhMMY43p27u22Pof5bFUF3URvNWMBEHC0ASy7MScTOOjSR73GY0nFLLicq4XM9
    1IveNgFMxXfEbJCs5BkTqIChQNj0nk/6VXwkGP0Xe4MNQIO3v2jv8QNnCMrI6/lu
    d9aGejLc9/0jYNQ6ejLCfCIzgKUydRh6AOaYGe6DU7ME06EuWvWWbkwOTQG60W1v
    SXw/B78CcuT3WWBlTxHGkUtj3gTbo9rXXNH7IL6RTf9WIey54+mlCUhcmgjtmA5N
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=umn.edu header.i=@umn.edu header.b=VaOwIRZP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=umn.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=umn.edu header.i=@umn.edu header.b=VaOwIRZP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20160920;
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
X-CM-Envelope: MS4wfLnvjsWEs4kLKWXkoyh4FyRP/o8POMLOpJa34J1GnKwg8til426tGIfRASu9qwAaMgmrjRwhW/LuqWmZwdulekSq9giEOOSKF/YlrUWzkIyfY8xDC9ft
    hrou5m3n+n1BBJYv+Ov+lx6eVr5mpPawYIRFzJAG/JoGFEL7k1EzosM6WggmZ3wA+cN/O70O41qScObQ2GebZO+hfOGBqK/+t0CtjKwAWDHRAKtH0LHsHZqa
    cFCE5K6ORDtw5cPjZpQ5Yg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=V7AQB2RXs-Qyrx_JfUcA:9
    a=t2cJfBTxGDhae4-D:21 a=iaGjjXZ4o8yTtykl:21 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpi16wH7FTvRp/jDhFngFx4WvyQq5guWlvOumvsPJFEj8yNVpwBAqcH/9HxvIQgmOOecAau4DLTTrDQSRKy9ds=
MIME-Version: 1.0
In-Reply-To: <69A8B9D9-9330-4750-BAAC-94480A1072D5@intel.com>
References: <1524872704-13391-1-git-send-email-wang6495@umn.edu>
 <8E6ADED8-592E-4794-8CAB-913A325B1971@intel.com>
 <20180429132058.GB5972@kroah.com>
 <69A8B9D9-9330-4750-BAAC-94480A1072D5@intel.com>
From: Wenwen Wang <wang6495@umn.edu>
Date: Mon, 30 Apr 2018 17:43:43 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dAdozKVxPgW5CowWB7xM3E=AJ-o9bL6S1NvRwb54vNmQ@mail.gmail.com>
Message-ID: <CAAa=b7dAdozKVxPgW5CowWB7xM3E=AJ-o9bL6S1NvRwb54vNmQ@mail.gmail.com>
Subject: Re: [PATCH] staging: luster: llite: fix a potential missing-check bug
 when copying lumv
To: "Dilger, Andreas" <andreas.dilger@intel.com>
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
 Aastha Gupta <aastha.gupta4104@gmail.com>, Jeff Layton <jlayton@redhat.com>,
 "Drokin, Oleg" <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wenwen Wang <wang6495@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>,
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

On Mon, Apr 30, 2018 at 5:38 PM, Dilger, Andreas
<andreas.dilger@intel.com> wrote:
> On Apr 29, 2018, at 07:20, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>
>> On Sat, Apr 28, 2018 at 04:04:25PM +0000, Dilger, Andreas wrote:
>>> On Apr 27, 2018, at 17:45, Wenwen Wang <wang6495@umn.edu> wrote:
>>>> [PATCH] staging: luster: llite: fix potential missing-check bug when copying lumv
>>>
>>> (typo) s/luster/lustre/
>>>
>>>> In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
>>>> using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
>>>> LOV_USER_MAGIV_V3, lumv3 will be modified by the second copy from the user
>>>
>>> (typo) s/MAGIV/MAGIC/
>>>
>>>> space. The second copy is necessary, because the two versions (i.e.,
>>>> lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
>>>> However, given that the user data resides in the user space, a malicious
>>>> user-space process can race to change the data between the two copies. By
>>>> doing so, the attacker can provide a data with an inconsistent version,
>>>> e.g., v1 version + v3 data. This can lead to logical errors in the
>>>> following execution in ll_dir_setstripe(), which performs different actions
>>>> according to the version specified by the field lmm_magic.
>>>
>>> This isn't a serious bug in the end.  The LOV_USER_MAGIC_V3 check just copies
>>> a bit more data from userspace (the lmm_pool field).  It would be more of a
>>> problem if the reverse was possible (copy smaller V1 buffer, but change the
>>> magic to LOV_USER_MAGIC_V3 afterward), but this isn't possible since the second
>>> copy is not done if there is a V1 magic.  If the user changes from V3 magic
>>> to V1 in a racy manner it means less data will be used than copied, which
>>> is harmless.
>>>
>>>> This patch rechecks the version field lmm_magic in the second copy.  If the
>>>> version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
>>>> returned: -EINVAL.
>>>
>>> This isn't a bad idea in any case, since it verifies the data copied from
>>> userspace is still valid.
>>
>> So you agree with this patch?  Or do not?
>>
>> confused,
>
> I don't think it fixes a real bug, but it makes the code a bit more clear,
> so I'm OK to land it (with minor corrections to commit message per above).
>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation
>

Thanks! I will re-submit the patch with the corrected commit message.

Wenwen
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
