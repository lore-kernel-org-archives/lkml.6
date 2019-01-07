Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38AC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9612085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a33XiXj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfAGR56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:57:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44543 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:57:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so482809plt.11;
        Mon, 07 Jan 2019 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LyK0RGSnDLBKcnzEtoopjbp/ZcAzp0tD5nabM9I/cFg=;
        b=a33XiXj++aofqToiVtFvZNO/wxrOjwILKPk5WSNYkVMikCV7CWl/JcdUnRbQd2hb5E
         xaM3Fy9AJ7G4VrqezIGr3sKLxZyvWkAm5vKlN1ULrHSUQWvfXwhmYqLHVXCp6ivG4nGI
         QDrTV7qZlsewO0slAnxJtqkZ3z8GvPDSbjrTHZvAmwbxTmL9ThI0dixkAZR9SnXuWu0f
         f9cLnu3te0Axap70oCh90VgIuabeA6i+BOy+x7qkPbYQVW7xvNo3pwUVfMR11IK6fFV0
         bTWXcdIoCsVmdRhkqcFTWYHs//v/mVmRaybwI07uLO+a8E1bb/3IAhLyQvgD0l0sxGaN
         aHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LyK0RGSnDLBKcnzEtoopjbp/ZcAzp0tD5nabM9I/cFg=;
        b=NVK/xmKGgPEhz3snl20iNk8j6OcB2Wa03Yef82V6WdcbEdBBsDDplizfJgUFiYjdoc
         fiX07e4rLErCotrCRPXzawLOXFnF6E1LddQTIQRV8ts3ypyIUhvy63hsk6ejhQ+QyfjT
         g9hOAi1yP4SM/z6NNah3My0cEEPKB2p2KMKw++UF5H3uV7BMPbGpSXchYAoso7F8ncWH
         5HcG+8fzOd5Z7vIYrSVC54IxS7JBdWobuhj94V2xxSBNZNe31tfUjQ+ByGq9z9kLsayx
         m5uN38kWiovmmv2gr2KHgMRtx3rg//wXBV5JsJ1DfCy3FBRra7f+etJwVgkI42iM1qyN
         feZg==
X-Gm-Message-State: AJcUukdUo//jOuYl+saBRBVJWPKIIpDucqTEqdgZ+LYaU7dlYct9BANV
        MGGHa/wTqUnPkXMhLfHNsNw=
X-Google-Smtp-Source: ALg8bN73E42eX/ytRjx3/WSQcdjuWrBh5FwIToHcO+VSHd21ugH+t8YobaTM97vaRCB8sWnb8o9uVg==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr63434845pln.100.1546883877196;
        Mon, 07 Jan 2019 09:57:57 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id i184sm93904921pfc.41.2019.01.07.09.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:57:56 -0800 (PST)
Date:   Mon, 7 Jan 2019 23:27:48 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: ad7192: replaced bool in struct
Message-ID: <20190107175748.GA29220@himanshu-Vostro-3559>
References: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
 <20181224095823.GA17061@himanshu-Vostro-3559>
 <8E720BF2-7AFC-4FFA-8FA2-5A403FD5DD1D@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8E720BF2-7AFC-4FFA-8FA2-5A403FD5DD1D@konsulko.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 01:25:27PM -0800, Matt Ranostay wrote:
> 
> > On Dec 24, 2018, at 01:58, Himanshu Jha <himanshujha199640@gmail.com> wrote:
> > 
> >> On Fri, Dec 21, 2018 at 03:26:26PM -0800, Amir Mahdi Ghorbanian wrote:
> >> Replaced bool in struct with unsigned int bitfield to conserve space and
> >> more clearly define size of varibales
> 
> Important thing to note is depending on padding, alignment, and position of field it probably won’t save any space.

Well, then what do you say about the following results ;-)

Before:
------

himanshu@himanshu-Vostro-3559:~/gsoc/linux$ pahole -C ad7192_platform_data drivers/staging/iio/adc/ad7192.o
struct ad7192_platform_data {
	u16                        vref_mv;              /*     0     2 */
	u8                         clock_source_sel;     /*     2     1 */

	/* XXX 1 byte hole, try to pack */

	u32                        ext_clk_hz;           /*     4     4 */
	bool                       refin2_en;            /*     8     1 */
	bool                       rej60_en;             /*     9     1 */
	bool                       sinc3_en;             /*    10     1 */
	bool                       chop_en;              /*    11     1 */
	bool                       buf_en;               /*    12     1 */
	bool                       unipolar_en;          /*    13     1 */
	bool                       burnout_curr_en;      /*    14     1 */

	/* size: 16, cachelines: 1, members: 10 */
	/* sum members: 14, holes: 1, sum holes: 1 */
	/* padding: 1 */
	/* last cacheline: 16 bytes */
};

After:
-----

himanshu@himanshu-Vostro-3559:~/gsoc/linux$ pahole -C ad7192_platform_data drivers/staging/iio/adc/ad7192.o
struct ad7192_platform_data {
	u16                        vref_mv;              /*     0     2 */
	u8                         clock_source_sel;     /*     2     1 */

	/* XXX 1 byte hole, try to pack */

	u32                        ext_clk_hz;           /*     4     4 */
	unsigned int               refin2_en:1;          /*     8:31  4 */
	unsigned int               rej60_en:1;           /*     8:30  4 */
	unsigned int               sinc3_en:1;           /*     8:29  4 */
	unsigned int               chop_en:1;            /*     8:28  4 */
	unsigned int               buf_en:1;             /*     8:27  4 */
	unsigned int               unipolar_en:1;        /*     8:26  4 */
	unsigned int               burnout_curr_en:1;    /*     8:25  4 */

	/* size: 12, cachelines: 1, members: 10 */
	/* sum members: 11, holes: 1, sum holes: 1 */
	/* bit_padding: 25 bits */
	/* last cacheline: 12 bytes */
};

> Also for internal unpacked structures it really makes little sense to save a few bytes of data. Don’t read into that packed structures are good.. they usually aren’t :)

Yes, agreed, but I often see patches to save few bytes by marking
array as static.

There is some effort in this direction:
https://lore.kernel.org/lkml/20181221235230.GC13168@ziepe.ca/

Very likely to get more patches if the above patch gets merged.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
