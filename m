Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-507227-1525252357-3-5552795239362509906
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525252356; b=fAWT8vMpv5i7zscCUKqH8iMbFE/oeX32Dc86pCmu3Ut15D/1IH
    aKx0limUXsudTY3fdVcrHxC6IHPTMTzwXyaJAc51MS5papYDXy3RntX4fwtC/nQA
    M9smkjguFXE6S3U0cFMhGeY9aSdBj0JM9G7HxuxgQe90Hil0y4nodz7M8v9RaDwg
    i1H6RJi9OtU51i2mbnVetOeUP4iKbLb2cCmF00jWRnAXK2XbuZ9jMv/V00FtHBZf
    lfpBaFHTP6KrdmaAAjveaF/KoKENb2HiClGLV9i9yXszN6DVL2cxg18vxl0YeXnD
    s1gCGrn6dV9cCYgEGmT+q3Y0PYto/Pu2gRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525252356;
    bh=R1dyMxSdWOuydV+jojb8SwFJfkS7Pgulte1HO9ec/Uo=; b=iSgS0vV8wm0a
    g28fgIgoXQUUmM8ADEBC/u6+PXiWH7tv3Z7jwNrhJK0xVWJoD17ECREVWROZhThc
    QbSbjCOwGvcNZo3XmNqyi9VVdkbhLErcHWYVuqkp6SCIfsj4i52nFiO4Uu2Wz31+
    RActz1TJo/hZr+m8AuREYd77s0xu7a6TUhKuIXh0hjs6YrLK94vaQh2idxMleX7i
    cMUnt76N0MUndZvlWYus8teAYxE1yXXxv7HDNhHm/byHv7LUSV+Y2dovpBZDXyOa
    5bmZYjKEQlIJPCFiVuFC3/b2y3Ht4WQt2lYMxmuLiLKyJg1C1MFQkFgxP9XUNi+m
    nSC/hp7N+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOpiwoHHmQHfFIWogXaHysTAt3BDLIFXucpyBGh1++LhgccC4iru5ZsISYpPM6v8MWCRroi+K/hD3dtn2lfqhMAFDI1hFwnpKT71tzzutQ1jiPlR9BXr
    Z5jJsmNpGVCdB4uwnNpYzg+n4JZoU3A6NfAGBt3OiPMjmAumD32+LDym+q1+iw1SSbnbmYXnyhkulWns/S6CbgpzvvPZlgsDBa8M4gsiKPqG0WZysxarOCFO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=NEAV23lmAAAA:8 a=jU4qhlNgAAAA:8 a=VwQbUJbxAAAA:8
    a=-0inlo09IisWk7CntnsA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeEBJMe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 05:12:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750897AbeEBJMd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 May 2018 05:12:33 -0400
Date: Wed, 2 May 2018 11:12:27 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Chris Mason <clm@fb.com>
Cc: brouer@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180502111227.346f355e@redhat.com>
In-Reply-To: <EED9C7CB-BC5D-4E2D-B0CC-0003F682C73B@fb.com>
References: <20180306013457.1955486-1-ast@kernel.org>
        <CA+55aFx5Q8D3cmuoXJFV9Ok_vc3fd3rNP-5onqFTPTtfZgi=HQ@mail.gmail.com>
        <EED9C7CB-BC5D-4E2D-B0CC-0003F682C73B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Tue, 6 Mar 2018 15:42:41 -0800 Chris Mason <clm@fb.com> wrote:
> On 6 Mar 2018, at 11:12, Linus Torvalds wrote:
> 
[...]
> >
> > I do *not* want this to be a magical way to hide things.  
> 
> Especially early on, this makes a lot of sense.  But I wanted to plug 
> bps and the hopefully growing set of bpf introspection tools:
> 
> https://github.com/iovisor/bcc/blob/master/introspection/bps_example.txt
> 
> Long term these are probably a good place to tell the admin what's going 
> on.
(related to bpf itself not modprobe subject)

Hi Chris,

I just want to point out that the tool 'bpftool', is currently the
dominating tool for eBPF introspection.  And the 'bps' tool you mention
seems to have gained less (open source) traction.

The bpftool is part of the kernel git-tree: tools/bpf/bpftool
 https://github.com/torvalds/linux/blob/master/tools/bpf/bpftool/

And it even have bash-completion and man-pages in RST format so they
even render nicely when viewed via github:

 https://github.com/torvalds/linux/blob/master/tools/bpf/bpftool/Documentation/bpftool.rst
 https://github.com/torvalds/linux/blob/master/tools/bpf/bpftool/Documentation/bpftool-prog.rst
 https://github.com/torvalds/linux/blob/master/tools/bpf/bpftool/Documentation/bpftool-map.rst

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
