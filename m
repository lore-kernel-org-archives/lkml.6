Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC250C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6216E208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="ZbNG0WWt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jrf92pBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6216E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeFRF3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:29:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45315 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752868AbeFRF3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:29:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CB71B2134B;
        Mon, 18 Jun 2018 01:29:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Jun 2018 01:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=G+Dt0r+Qwwm5m7HCzANthiYlAXgxP
        XUFBloM8+TN4nQ=; b=ZbNG0WWtacmVXrtXb6/Jzpt+OXAbXahDgW9aCtv4zTnDf
        To7VF2w5SZcdezDD7De5OsYyQpW6hJt+IAfGPzTcZ4r7ycf758u3b6gYs6fuxuN0
        VYC4T5weXJalS5QefT8+DcI8I88yNO0xHVcVmKwzRia1uXB8M/EIvQAtFbXApwgv
        5pdARHh9wCGzZ3gEGUPdxCqsz1ScZO2L6P1LWnawvlih/JYxDaBzTESw38gH0Y07
        7x7yrPHw7JXFUwW3uGRMWHl8jQ53MWjGYaPBehK5U4yyJpXRMPUT4Cs+oo0dm7Rq
        JUi1I9vmxZYb3DnlHrrkUPRc2RvusSTmxERQEbfew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G+Dt0r
        +Qwwm5m7HCzANthiYlAXgxPXUFBloM8+TN4nQ=; b=Jrf92pBdNOnS2XBuV2hGVl
        MdFDeNWduuvr/t5VSmuXWjyqG1NtZPy8twHI9zo2r98izQGb80dJ78eFTOPmjYSv
        8mzwg18CFlo/iCSUz351czJez6APRVdl1yAqmQXyQqb3ckQITonfL6T05+zhzb/x
        CIRgi1URNsM+IXl6s3oLN/u9QAucjWfAkpLIPJjhDK6JbgCDHci914mem8DPycFT
        rn5KUE2SibQm3P1h0oIXJZkOJEcLLsLNeSXOb0h1s7qpahmjisITeaTg1mnWoY9T
        rHY/8zKwetI5bP8oYK+SuxziwGetNiA/c2oAkV0kk8ZWwT3MEGcfSOqES33u2Ueg
        ==
X-ME-Proxy: <xmx:IEMnW61CIF08su13-OdGYngx331z7COZR16XU5R8XsDepLeJPGnJ8g>
    <xmx:IEMnW_0dakheu7n61GJt_CC5-isa-sftnfZENr7t0CjIx0YtrVHjMg>
    <xmx:IEMnW_ytuMqjeW1yaP90dDUU8JoA-W5WsFV30MQ1gdlzCwLjKp9Ktw>
    <xmx:IEMnWzUtQSbks9iGdhHNpK39-dyZFqFRodbLRK4HNFxnMFts0t0jJA>
    <xmx:IEMnW0rTqNQ7oE8IX1BvL7lwq1IiZ24aZdEZao_0DTMPxYWHijWF_g>
    <xmx:IEMnW6EldIrNg5jiGmhXz6Bhg340gsgpoFfdWu18fHT-LmjbXz-sEQ>
X-ME-Sender: <xms:IEMnWwjZFuLwawA15axgRrIjc4xEk-CztA2YAa4V2Im1k4Y44pFHPA>
Received: from localhost (124-171-19-110.dyn.iinet.net.au [124.171.19.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCF4F102C0;
        Mon, 18 Jun 2018 01:29:03 -0400 (EDT)
Date:   Mon, 18 Jun 2018 15:29:00 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the random tree
Message-ID: <20180618052900.GA4579@eros>
References: <20180608133748.58a272d5@canb.auug.org.au>
 <20180618133523.30db3ba0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180618133523.30db3ba0@canb.auug.org.au>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 01:35:23PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Fri, 8 Jun 2018 13:37:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > After merging the random tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >=20
> > lib/vsprintf.c:1668:13: warning: 'have_filled_random_ptr_key' defined b=
ut not used [-Wunused-variable]
> >  static bool have_filled_random_ptr_key __read_mostly;
> >              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Introduced by commit
> >=20
> >   bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash=
")
>=20
> I am still getting this ...

This is fixed in:

	[PATCH v7 0/4] enable early printing of hashed pointers


FYI v8 to come with unrelated change removing EXPORT_SYMBOL() (as suggested
on LKML in response to v7)



thanks,
Tobin.
