Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F4EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD3F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du6al/Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD3F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbeKPKg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:36:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39152 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeKPKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:36:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id b13so23061717wrx.6;
        Thu, 15 Nov 2018 16:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIBdzFqMQTHke1SsKxqs2G+9FzdFsGjppljq4GaqH9I=;
        b=Du6al/Eo69FIPg0EjQzf+OdUqFDOI3TAVIvWejXRqfA7B0cHY+EUKJFJG2Z1Cug08V
         1o7oVPsd3OpykPyY064DBGjkjWpSdfiIbWt5Joob0G7CcaKWYfYvjiHLmTkRvxkH2iJ6
         PlxS2zD07a6bvOA2rdCO59rm/Kozx46UwOVsHksFc7TQc2yyBb5uhFyGs5YLfOIQGcm2
         hMtuT/+K0+CP4XXs8PJjBjkOkpyuBIUVbACJkGy+jkIQUIu2osmL+hTrj3ywCRzWPw2B
         arYJatYtMWqM+7XlL80Udui6cWM8OaUz2awj+9eIDAyf5pDrsng1YDJuIZbW3qN9PeZt
         bEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DIBdzFqMQTHke1SsKxqs2G+9FzdFsGjppljq4GaqH9I=;
        b=o+J25U5sgXHgSgnL+9Kjtl1fuoJ5ipSCzOIWdHpXRkswsx6YsqCVJGd96LGCLWlcUN
         rlAZM81IjjLshG7jMuBiKfWYMYI3NkGc4Q1AKZ4zbscgF8bE9sir2sdlSKEIeJfXdy07
         TbL0fOk/e8ewtraFmHnHBW4Z0KZH4+e6/WFfITwiCL5KWfkl+25RETY43DTKE8c+Z2+K
         TV8JYtv+BslnbDn3qvImhzlHrr8rXAgE48NlhOZ0Xrn13SfxQGnYynk2uv28gR9dwA70
         Ie355cgTEAnTII+FhOTrj95RTrAe/O0ebwP9JMYtrhC/Rx8qMifBen3groT1jEyo+XRK
         eExA==
X-Gm-Message-State: AGRZ1gKakMU4+zo6wx25/up5yFOPRPLy9hwWSMpgi5dlCUEW1EHuouww
        0pWA8SF4DCDYzPJ/zX3OIt9lBe1p
X-Google-Smtp-Source: AJdET5fXoKlezUgrtoAMO2mTZQzk+p5duUIDAaf67E0wnomYrUR80wbSdYLQT26Rg12mImNOHD8Bng==
X-Received: by 2002:a5d:424a:: with SMTP id s10-v6mr7341709wrr.260.1542328003886;
        Thu, 15 Nov 2018 16:26:43 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm18843546wro.28.2018.11.15.16.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 16:26:42 -0800 (PST)
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181110190521.GA2627@thunk.org>
 <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
 <20181111141426.GA7377@thunk.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0f
 UGFvbG8gQm9uemluaSA8Ym9uemluaUBnbnUub3JnPsLBTQQTAQIAIwUCVEJ7AwIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEH4VEAzNNmmxNcwOniaZVLsuy1lW/ntYCA0Caz0i
 sHpmecK8aWlvL9wpQCk4GlOX9L1emyYXZPmzIYB0IRqmSzAlZxi+A2qm9XOxs5gJ2xqMEXX5
 FMtUH3kpkWWJeLqe7z0EoQdUI4EG988uv/tdZyqjUn2XJE+K01x7r3MkUSFz/HZKZiCvYuze
 VlS0NTYdUt5jBXualvAwNKfxEkrxeHjxgdFHjYWhjflahY7TNRmuqPM/Lx7wAuyoDjlYNE40
 Z+Kun4/KjMbjgpcF4Nf3PJQR8qXI6p3so2qsSn91tY7DFSJO6v2HwFJkC2jU95wxfNmTEUZc
 znXahYbVOwCDJRuPrE5GKFd/XJU9u5hNtr/uYipHij01WXal2cce1S5mn1/HuM1yo1u8xdHy
 IupCd57EWI948e8BlhpujUCU2tzOb2iYS0kpmJ9/oLVZrOcSZCcCl2P0AaCAsj59z2kwQS9D
 du0WxUs8waso0Qq6tDEHo8yLCOJDzSz4oojTtWe4zsulVnWV+wu70AioemAT8S6JOtlu60C5
 dHgQUD1Tp+ReXpDKXmjbASJx4otvW0qah3o6JaqO79tbDqIvncu3tewwp6c85uZd48JnIOh3
 utBAu684nJakbbvZUGikJfxd887ATQRUQnHuAQgAx4dxXO6/Zun0eVYOnr5GRl76+2UrAAem
 Vv9Yfn2PbDIbxXqLff7oyVJIkw4WdhQIIvvtu5zH24iYjmdfbg8iWpP7NqxUQRUZJEWbx2CR
 wkMHtOmzQiQ2tSLjKh/cHeyFH68xjeLcinR7jXMrHQK+UCEw6jqi1oeZzGvfmxarUmS0uRuf
 fAb589AJW50kkQK9VD/9QC2FJISSUDnRC0PawGSZDXhmvITJMdD4TjYrePYhSY4uuIV02v02
 8TVAaYbIhxvDY0hUQE4r8ZbGRLn52bEzaIPgl1p/adKfeOUeMReg/CkyzQpmyB1TSk8lDMxQ
 zCYHXAzwnGi8WU9iuE1P0wARAQABwsEzBBgBAgAJBQJUQnHuAhsMAAoJEH4VEAzNNmmxp1EO
 oJy0uZggJm7gZKeJ7iUpeX4eqUtqelUw6gU2daz2hE/jsxsTbC/w5piHmk1H1VWDKEM4bQBT
 uiJ0bfo55SWsUNN+c9hhIX+Y8LEe22izK3w7mRpvGcg+/ZRG4DEMHLP6JVsv5GMpoYwYOmHn
 plOzCXHvmdlW0i6SrMsBDl9rw4AtIa6bRwWLim1lQ6EM3PWifPrWSUPrPcw4OLSwFk0CPqC4
 HYv/7ZnASVkR5EERFF3+6iaaVi5OgBd81F1TCvCX2BEyIDRZLJNvX3TOd5FEN+lIrl26xecz
 876SvcOb5SL5SKg9/rCBufdPSjojkGFWGziHiFaYhbuI2E+NfWLJtd+ZvWAAV+O0d8vFFSvr
 iy9enJ8kxJwhC0ECbSKFY+W1eTIhMD3aeAKY90drozWEyHhENf4l/V+Ja5vOnW+gCDQkGt2Y
 1lJAPPSIqZKvHzGShdh8DduC0U3xYkfbGAUvbxeepjgzp0uEnBXfPTy09JGpgWbg0w91GyfT
 /ujKaGd4vxG2Ei+MMNDmS1SMx7wu0evvQ5kT9NPzyq8R2GIhVSiAd2jioGuTjX6AZCFv3ToO
 53DliFMkVTecLptsXaesuUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <98fe5cf7-722a-37d6-156d-842e8812e430@redhat.com>
Date:   Fri, 16 Nov 2018 01:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181111141426.GA7377@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2018 15:14, Theodore Y. Ts'o wrote:
> On Sun, Nov 11, 2018 at 02:26:45PM +0100, Paolo Bonzini wrote:
>>
>> I'm not very eBPF savvy, the question I have is: what kind of
>> information about the running process is available in an eBPF program?
>> For example, even considering only the examples you make, would it be
>> able to access the CDB, the capabilities and uid/gid of the task, the
>> SCSI device type, the WWN?  Of course you also need the mode of the file
>> descriptor in order to allow SANITIZE ERASE if the disk is opened for write.
> 
> The basic uid/gid of the task is certainly available.  For storage
> stack specific things, it's a matter of what we make available to the
> eBPF function.  For example, there is an experimental netfilter
> replacement which uses eBPF; obviously that requires making the packet
> which is being inspecting so it can be given a thumbs up or thumbs
> down result.  That's going to require letting the eBPF function to
> have access to the network header, access to the connection tracking
> tables, etc.

Yeah, and there are even already helpers such as
bpf_get_current_uid_gid.  So that part can be done in a sort-of generic way.

I can try and do the work, but I'd like some agreement on the design
first...  For example a more important question is how would the BPF
filter be attached?  Two possibilities that come to mind are:

- add it to the /dev/sg* or /dev/sd* struct file(*) via a ioctl, and use
pass the file descriptor to the unprivileged QEMU after setting up the
BPF filter, via either fork() or SCM_RIGHTS.  This would be a very nice
model for privilege separation, but I'm afraid it would not work for
your use case

- add BPF programs to cgroups, in the form of a new
BPF_PROG_TYPE_CGROUP_CDB_FILTER or something like that.  That would also
work for my usecase, and it seems to be in line with how the network
guys are doing things.  So it would seem like the way to go.

Some other details...  Registering the first cgroup-based filter would
disable the default filter; if multiple filters are attached, the
outcomes of all filters would be AND-ed, also similarly to how socket
and sockaddr cgroup BPF works.  Finally, filters would be applied also
to processes with CAP_SYS_RAWIO, unlike the current filter.

Needless to say, this would not add special case code, but it would
still add a substantial amount of code, probably comparable to this series.

Christoph?

Paolo

(*) that's not immediate for /dev/sd*, because it would require using
the block device file's private_data; that's not possible yet via struct
block_device_operations, but as far as I can tell block devices
themselves do not need the private_data, so it is at least doable.
