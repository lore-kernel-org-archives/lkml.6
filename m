Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D2EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED682086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iCzfxxlE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AJSSxy67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED682086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJLMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:53:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJLMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:53:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1CF6160B7A; Fri, 12 Oct 2018 05:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539321777;
        bh=PQk4ghll7M2SlTQ8n/VNfrOZYpnVO76DMikfP4DLB9I=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=iCzfxxlEE9Vy+J1NWZbzpFA4bX8SD78p81pqg5pZCG6swxm3THUxac+ybB2sDvlTW
         VI9gut+miIFHyRMmb9SbS1KwZqDNSZBWfnYnVDLqNXLsNpcTOrYJ9bfIB/NgiGgOxm
         kUPEQj43MA0ILPBxf8HKHCi+wKUzFiebYYgXm5M0=
Received: from tbhardwa (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tbhardwa@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55EF260316;
        Fri, 12 Oct 2018 05:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539321776;
        bh=PQk4ghll7M2SlTQ8n/VNfrOZYpnVO76DMikfP4DLB9I=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=AJSSxy679V7gS11r/wPLkz8TV9fgmt8lG6TL3Zgmv0k7c/pKpwwZE2YXpYQwxDy4c
         MUBIZRx5vP98ab1U5Zr9mBUH6W7LAJiAI8D/bZaShck73WWgwyLFo960t382qrLrfK
         oApev25vqE4JLsQlH2/EWLnoPD9+jGTyBp+hmRVg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55EF260316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbhardwa@codeaurora.org
From:   <tbhardwa@codeaurora.org>
To:     "'Zhang, Ning A'" <ning.a.zhang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <1539313441.21249.3.camel@intel.com> <1539318782.21249.7.camel@intel.com>
In-Reply-To: <1539318782.21249.7.camel@intel.com>
Subject: RE: question about V4L2_MEMORY_USERPTR on 64bit applications
Date:   Fri, 12 Oct 2018 10:52:51 +0530
Message-ID: <000601d461eb$a1f7afc0$e5e70f40$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIZOT1Qp2mifVHgqOiMlO5tZ7T4WgG2r2gYpIOuUQA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64 bit kernel have 64 bit long(not 32 bit), which is not the case with =
userspace (in 64 bit userspace long is 32-bit). Probably thig got you =
confused.

-----Original Message-----
From: linux-media-owner@vger.kernel.org =
<linux-media-owner@vger.kernel.org> On Behalf Of Zhang, Ning A
Sent: Friday, October 12, 2018 10:03 AM
To: linux-kernel@vger.kernel.org; linux-media@vger.kernel.org
Subject: Re: question about V4L2_MEMORY_USERPTR on 64bit applications

sorry for wrong question, I really meet memory address truncated issue, =
when use V4L2 kernel APIs.

in a kernel thread created by kernel_thread() I vm_mmap a shmem_file to =
addr: 00007ffff7fa8000 and queue it to V4L2, after dequeue it, and I =
find the address is truncated to 00000000f7fa8000

I use __u64 {aka long long unsigned int} to save address, and I find =
userptr is unsigned long, wrongly think it as "data truncated"
and a lot of __u32 in this structure.

everything works fine, but I still don't understand why high 32bit be =
0..

BR.
Ning.


=E5=9C=A8 2018-10-12=E4=BA=94=E7=9A=84 11:04 +0800=EF=BC=8CZhang =
Ning=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> I have question about V4L2_MEMORY_USERPTR on 64bit applications.
>=20
> struct v4l2_buffer {
> 	__u32			index;
> 	__u32			type;
> 	__u32			bytesused;
> 	__u32			flags;
> 	__u32			field;
> 	struct timeval		timestamp;
> 	struct v4l2_timecode	timecode;
> 	__u32			sequence;
>=20
> 	/* memory location */
> 	__u32			memory;
> 	union {
> 		__u32           offset;
> 		unsigned long   userptr;   <<<--- this is a 32bit addr.
> 		struct v4l2_plane *planes;
> 		__s32		fd;
> 	} m;
> 	__u32			length;
> 	__u32			reserved2;
> 	__u32			reserved;
> };
>=20
> when use a 64bit application, memory from malloc is 64bit address.
> memory from GPU (eg, intel i915) are also 64bit address.
>=20
> when use these kind of memory as V4L2_MEMORY_USERPTR, address will be=20
> truncated into 32bit.
>=20
> this would be error, but actually not. I really don't understand.
>=20
> BR.
> Ning.

