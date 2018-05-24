Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527166721-2-14790338563312260847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527166721; b=R6Z/ANMymdcy04tbUqIfuXU+Fd8LTn/Ldh/EpFzPoXi7KJ3d2d
    JBnLxzm11s/3EhtDImv4dSVF9Z80KRaYaupZVGYHw7URKaiDqBoQXXg2xGt33vh3
    L1ueGgdEe1y7WXsbz3Wl+ZstHGCws08w38KEDi71N1kmdZFFGWk4GpRUd/6kzooA
    RY63t9lftg8YBoBdur+/oq6UI0xHhJR/dCYjfaLljbEUQTSAmGLVvO06p3L+9koA
    YgyH+t2SuuE6GbXzcfVJjZ2UJfaP5n8+Ah7+sh2QiocLKJi4dmVDGjVCeXo2139B
    L1h6v97p4hUsRYUJ7C71jauwBIiT/C4wXhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527166721; bh=bKKMgaSMXOUO0pdcuzFEz0GnI8z6CB
    +xcC3L7IAtuFY=; b=ToQLQFT15Uv5pbf94prpqRyZDlYgbHvYh7+ILXI7FgVJZ9
    zClp+Ebth5bpAn+uLoJUrDOaGM219RJieS1GTjM/5znqCXNMgqXMvdSyevuTZY4G
    3u1/WWWKyNPOznAZxzmAZuF52ZhlRXIwfBsfY3Pu3yHvElpzV3dI+bfnZAznmoa7
    MvLBMBqOnBwD6XGCLR4DBfK9KyRscVGAG02dIZHcnRAkBxdVPU3177MjgDMNlK0z
    A74fdAw3+J6YrbXU7pQ5DuFQrY9lL01h0x4kR2WWg7DDXvEkA6Ec8MZbURcWmKv9
    unRhV/qwJYeRRUs7YOjp2v9zZi3HBvgiUm7bm/Kg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=GLeduTFV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=GLeduTFV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFBBvY72W2DYWJzbu6NAU7MmlL05tAYZsQP+rm0Vswbsxn3hjNTvi5QNkqFcIg/Rm0mHh8n+8Hlx9JUeTRtahPkG4uZf4D+ul/e11x2YtanOaevZtXSi
    A+W5F+VxmceolhOEop9kmMm/Cn8l40S0CcLC2uaxfHE+KBCUlGXFc9gHe71WZ8s/Drs3DPIK29aE+So/h7/i1CKaOHqGWoHyUviA9R//Jn3Uo0bcwE0BUfjV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=PtDNVHqPAAAA:8 a=DfNHnWVPAAAA:8 a=iCtyMzwB7xAH08XU5WcA:9
    a=CjuIK1q_8ugA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964964AbeEXM6h (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 08:58:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964823AbeEXM6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 08:58:36 -0400
X-Google-Smtp-Source: AB8JxZpc3NME5waDN9d2Ywv5jYEhzH2P4BVugW8m3BcLE3vjMNE0lZCjR/qjU5OKtrOYKGpNB6sqUA==
Date: Thu, 24 May 2018 07:58:32 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 1/6] vfs: Don't allow changing the link count of
 an inode with an invalid uid or gid
Message-ID: <20180524125832.GP3401@ubuntu-xps13>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523232538.4880-1-ebiederm@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 06:25:33PM -0500, Eric W. Biederman wrote:
> Changing the link count of an inode via unlink or link will cause a
> write back of that inode.  If the uids or gids are invalid (aka not known
> to the kernel) writing the inode back may change the uid or gid in the
> filesystem.   To prevent possible filesystem and to avoid the need for
> filesystem maintainers to worry about it don't allow operations on
> inodes with an invalid uid or gid.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Acked-by: Seth Forshee <seth.forshee@canonical.com>
