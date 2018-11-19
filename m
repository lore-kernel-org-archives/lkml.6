Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C2AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B432145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pbMtruNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B432145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbeKTDNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:13:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57986 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389682AbeKTDN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:13:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAJGmg4P186227;
        Mon, 19 Nov 2018 16:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kjroibY1+r/vOeYYUGybAFBOv3bl3r62rGnV4IhWd60=;
 b=pbMtruNBKCqfx8Q48yrcuP649iui/IgFJfu/jvn27PaDO5QLZILjsUSyxxJRtF+01ZlU
 KmV9oBomkjMYa6YsyNaNFvxxYtnXTVaiuLgzDLZwwWHJEJDZkqdmmTFDNUD3hzS3Ibun
 c+2KofleQ7BYY+zLJV+NlL09RXKb2zx+3snCdSinNcr2ECRZgFiwqMX6rpCOcoCq0X3E
 hpimhteli22dWMAX84mwZQlQZGYwL12TpLwygX+lPliUkk9SuODcWI6u+JbyMWzX6clz
 8SOjzO/CRNt2a4Hx9NR+Y9u2pcou8QCHFWuY8tDD499h7vqyEfzGDgcqx+Z1GlkOAu/0 Dw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadtq809-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 16:48:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAJGmd71023590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 16:48:39 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAJGmbSo015675;
        Mon, 19 Nov 2018 16:48:37 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Nov 2018 08:48:37 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id BC8CC6A00EB; Mon, 19 Nov 2018 11:48:35 -0500 (EST)
Date:   Mon, 19 Nov 2018 11:48:35 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, grub-devel@gnu.org,
        Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, corbet@lwn.net, boris.ostrovsky@oracle.com
Subject: Re: PLEASE REVERT URGENTLY: Re: [PATCH v5 2/3] x86/boot: add acpi
 rsdp address to setup_header
Message-ID: <20181119164835.GF31468@char.us.oracle.com>
References: <20181010061456.22238-1-jgross@suse.com>
 <20181010061456.22238-3-jgross@suse.com>
 <f7c78ee7-b548-7f04-24da-7321b6c64c97@zytor.com>
 <bd2d17cd-072c-cad6-94ad-52373700a1c9@suse.com>
 <2934552c-d150-0afb-6fa9-9398cb94d86a@zytor.com>
 <5a2f5cb8-7332-f490-eabf-cfcbdcd1abc4@suse.com>
 <59ca1053-9176-f1db-6e6c-96b47aaaa09d@zytor.com>
 <f16c53a4-7a5c-de01-c3cc-095226f6ca40@suse.com>
 <3e773a2d-3f69-5ccd-7d8b-9878fba30d00@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e773a2d-3f69-5ccd-7d8b-9878fba30d00@zytor.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:49:39AM -0800, H. Peter Anvin wrote:
> On 11/10/18 1:03 AM, Juergen Gross wrote:
> > 
> > How would that help? The garabge data written could have the correct
> > terminal sentinel value by chance.
> > 
> > That's why I re-used an existing field in setup_header (the version) to
> > let grub tell the kernel which part of setup_header was written by grub.
> > 
> > That's the only way I could find to let the kernel distinguish between
> > garbage and actual data.
> 
> There is plenty of space *before* the setup_header part of struct boot_params
> too -- look a the various __pad fields, especially (in your case), __pad3[16]
> and __pad4[116] would suit the bill just fine.
> 
> >> It would be enormously helpful if you could find out any more details about
> >> exactly what they are doing to break things.
> > 
> > That's easy:
> > 
> > The memory layout is:
> > 
> > 0x1f1 bytes of data, including the sentinel, the setup_header, and then
> > more data.
> > 
> > grub did read the kernel's setup_header in the correct size into its
> > buffer (which contains random garbage before that), intializes the first
> > 0x1f1 including the sentinel byte, and then writes back the buffer, but
> > using a too large length for that.
> 
> Are you kidding me... it really overwrites it with completely random data, and
> not simply overspilling contents of the file?
> 
> In that case it might not be possible (or desirable) to use those N bytes
> following the setup_heaader, or we need to a bigger sentinel than one byte
> (probability being what it is, 256^n gets to be a pretty big number for any n,
> very quickly drowning in the noise compared to other potential sources of boot
> failures, and most likely less fatal than most.)
> 
> How big is this garbage dump?  I'm going to brave a guess it is 512 bytes.  In
> that case this is hardly a big deal: the E820 map begins at 0x290, and the
> setup_header maximum goes to 0x280, so it is only 15 bytes lost.  If it is
> worse than that, we would risk losing __pad8[48] and __pad9[276], and
> especially the latter would be painful. In those case perhaps we should use
> 0x281..0x290 as a 15-byte sentinel; that is going to be virtually foolproof.
> 
> I'm also thinking that it might be desirable to add a flags field (__pad2
> would be ideal) to struct boot_params; it would let us recycle some of the
> obsolete fields (hd0_info, hd1_info, sys_desc_table, olpc_ofw_header, ...) and
> perhaps be able to add some more robustness against these sort of things. This
> would be the right way to do what your version feedback mechanism would do.
> 
> The reason why the feedback mechanism is fundamentally broken is that it only
> gives the boot loader a way to assert that it supports a certain version of
> the protocol, but it doesn't say *which* bootloader does such an assert -- and
> therefore it is still wide open to implementation error.
> 
> We do, in fact, already have a feedback mechanism: the bootloader ID and
> bootloader version. One way we could deal with this problem is to bump the
> bootloader version reported by Grub, and add a quirk to the kernel that if the
> bootloader ID is Grub (7) and the version is less than a certain number, zero
> those fields. In fact, the more I think about it, this is what we should do.
> 
> That being said, Grub really needs to be kept honest.  They keep making both
> severe design (like refusing to use the BIOS and UEFI entry points provided by
> the kernel by default) and implementation errors, apparently without
> meaningful oversight. I really ask that the people more closely involved with
> Grub try to keep a closer eye on their code as it applies to Linux.

Cc-ing GRUB and Daniel Kiper (maintainer of GRUB).

Could folks please please CC Daniel Kiper on any of these patches in the future?

Thanks.
> 
> 	-hpa
