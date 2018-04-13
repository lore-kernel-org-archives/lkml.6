Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2330021-1523580647-2-8957619714228885808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523580646; b=vgSIptFm9rU6czA0Y1uDkaw0BpUYogzg4oiNuGRIArUsPfsj8N
    awQng9w+qgqf+pA18H2YN13CACMdFaTy0/3FDo8LVoLy0Gk45jQ6MzQEpNyRJtQy
    8b6dUW3631wrPdnmv/I4GZ1UMf7TTlAQ3/DCOtoyUHAu+Rz/vfB/Q/eq6KBGn4yo
    Hzh2Uc4x7oAeA13DIAoV10+8YIH/rN0mi+06xnTRiOjFsDqLFbKO2sX6PJQxy4mh
    h88THVutzHnsFjXEl6f5Rh8pecBhl2iaqTRxhsds1yEMRlKoLQED3oT3OOcN3a46
    vH5G5H8clglY2qJYzdg3lkYMm9tTtr+2pB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523580646; bh=l1gD9B6ijPLNBy79hnI8GxiT5HgUc3nHk0ibOUzq6c
    8=; b=fuaOEFDC54TZqEEdYipqDLu3MwBoS7PEs+mNscb8kiJHynit/I/U3Sn24f
    8kCf9q8D8mUL/COrRfIT3uWlNDqhGdp2pWIlgrVXurL8klF9r/8jGThMhazqx7p4
    7BzrIm0iHABULku02Ng9VL/0zjGgNT+1m0rGyPTaMKoa0FUnFTlJ6MsrBYLo1F9e
    fQQ7xlvdihsdvmZLAghdepgex8LL/1GOOlmT3Z8lvFjeMTRQ2HbEYLlXhyFYS4RE
    DREQtftp0Y3o8H1ZjCkTMDyUj7htI5JPX03e5F92PmEULmmBkEasnjppv/Grqroc
    IHGDzNbmsdhJDAvjO1WuMjkNXNWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKpl+mFfjgU3nwsnGAhjm7uLcQ0QDeWpIFtkW9U61YQZwHV2oWHNHYWU646uHI+x8uKoyrIm1eyk7zo672OiDP1yOfF3IUyWXcHQTahZqKmDM7D7bKmG
    Wjo4HJ/ptIZllamOLmWJw4l2H3fzOdGnFP1X49eN5T/ol/GSRtf1R6PwEirqTKEOmnPknDukKpJfI/XxCoaMxD69ibncEhDHA4+WNnjSSAAgPb7vREnLSNnZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=Tty9oNO6AAAA:8 a=20KFwNOVAAAA:8
    a=drOt6m5kAAAA:8 a=8DEaxwQfSJ-bmSo5xzQA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Bts-Es6F1CBXvF7u4C_G:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDMAum (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 20:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeDMAul (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 12 Apr 2018 20:50:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC3D217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
X-Google-Smtp-Source: AIpwx4+myuza7OOH/wOIMZuyWWQV/XigyRtW2IPw0evXTS/MzMxZU3AvWrzcMutUIrgOB6fQpxpy9FdfdCGupUNdxj8=
MIME-Version: 1.0
In-Reply-To: <20180409002239.163177-188-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com> <20180409002239.163177-188-alexander.levin@microsoft.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Thu, 12 Apr 2018 17:50:19 -0700
X-Gmail-Original-Message-ID: <CAB=NE6WSdypzgN0nYvhpBhaESPqG9py3ziUs92gV1ggyWuh6jw@mail.gmail.com>
Message-ID: <CAB=NE6WSdypzgN0nYvhpBhaESPqG9py3ziUs92gV1ggyWuh6jw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 188/293] fs: warn in case userspace lied
 about modprobe return
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 8, 2018 at 5:25 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@kernel.org>
>
> [ Upstream commit 41124db869b7e00e12052555f8987867ac01d70c ]
>
> kmod <= v19 was broken -- it could return 0 to modprobe calls,
> incorrectly assuming that a kernel module was built-in, whereas in
> reality the module was just forming in the kernel. The reason for this
> is an incorrect userspace heuristics. A userspace kmod fix is available
> for it [0], however should userspace break again we could go on with
> an failed get_fs_type() which is hard to debug as the request_module()
> is detected as returning 0. The first suspect would be that there is
> something worth with the kernel's module loader and obviously in this
> case that is not the issue.
>
> Since these issues are painful to debug complain when we know userspace
> has outright lied to us.
>
> [0] http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/libkmod-module.c?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4
>
> Suggested-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Jessica Yu <jeyu@redhat.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

The issue is real, and specially older kernels with older userspace
can suffer with pain. It doesn't follow the typical stable
candidate-fix, however, such simple check *can* help rule out tons of
stupid debugging where the culprit really was userspace.

 Luis
