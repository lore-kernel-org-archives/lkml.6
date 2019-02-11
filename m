Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75F320855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Tt1MYvL5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLLXNe0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfBKFWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:22:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54099 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfBKFWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:22:51 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B41D204B9;
        Mon, 11 Feb 2019 00:22:50 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute4.internal (MEProxy); Mon, 11 Feb 2019 00:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:date:in-reply-to:subject:references; s=fm2; bh=XEv
        m6ZA+fGIUi8Lya1ekc4etlnANUbCvCdTjSErcXOM=; b=Tt1MYvL5gYpIBofVPfU
        cpVkNIH0lG6ak8cBvAOp+m2XCIdf6Q63H8J0qw0dHGVgtHItCqS0w0tVTieXJBaW
        LBKJGQBoSZ3DaCULNqKtRiKhcivTjHTS1zH4qNnRcCKivMnsGcAxs01cCxUL/hzR
        dZDNjHlb488CAOP7nGD/DV05YwWfw16DkQcl+3Cjz8sFI1RvYgXEOXAf8IIiz7JO
        4avuk/f35OVXjyVmmKRIAXUaQTvjJqmDS7qIuhRU3xfdGusFW8b2OCwzF1A/DzbU
        5f0odvcKVAvoDwatSIXW8qiyNAaoUAlSe+GT70gL73UBBF7G8WyjoK7JGkL96rNb
        6ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=XEvm6ZA+fGIUi8Lya1ekc4etlnANUbCvCdTjSErcX
        OM=; b=mLLXNe0LhEWIjGyvs91BK8O9FRM7wESxmZR2uwszxh4+BUx0jo4Mz4VqK
        4RfkDLJystsW7xOhmvPwZoqpjqlEz7UD6hN7sTAxIKTPBG8mQEOapoVAThlHHC1C
        1CGHUoXbyO672wqKBH3vbN1OaLLIBNUbYN7yn/cvekkNOGxNZ1p11aVxfeJhS8MB
        P0spLaGN69mB+BVYOq8JNwnti7/kYa2VQRSXvPMdfy80SLau+nNCdSDdIKGHU9pv
        sW+ClOgI5Csfn5dvMNw3Br1gFDdD25ND+N/VwTXvLvStD5+YsKn1MXXtFBFIlduJ
        Bk2sfvE+8qDb7vGafE7tn98HXvsjw==
X-ME-Sender: <xms:pwZhXJT-Wt9ozd2lC87w_CxlGyPiF5DR2h8LUpd-6PNn1A-VSscDQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleejgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
    ffjgfufhesthhqredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
    rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qAZhXJwdFkYuEL7KhCbEK4GHpsun36oAtFMV9XsRISm2FH-ibVyxmA>
    <xmx:qAZhXD3RvrfeedrXyvhSbUiaP9AooGEJvwcEfacp0W_qcOV9QdMb4A>
    <xmx:qAZhXP7yl08KySqHULpDy3HsSmwuseWYJxUgqEPfJFscRONCjwn8fw>
    <xmx:qgZhXN47dZJ_lYI6YXtCC5tsFNoriU5azvn6er8JrLmc95fCoraeig>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id D75CB9E009; Mon, 11 Feb 2019 00:22:47 -0500 (EST)
Message-Id: <1549862567.1175306.1655243744.11AFF30D@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-950b8783
Date:   Mon, 11 Feb 2019 15:52:47 +1030
In-Reply-To: <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
 <20190124081544.GA1649@kroah.com>
 <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, at 05:59, Vijay Khemka wrote:
>=20
>=20
> =EF=BB=BFOn 1/24/19, 12:16 AM, "Greg Kroah-Hartman" <gregkh@linuxfoundati=
on.org> wrote:
>=20
>     On Wed, Jan 23, 2019 at 03:06:34PM -0800, Vijay Khemka wrote:
>     > Corrected some of return values with appropriate meanings.
>     >=20
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
>     >  1 file changed, 7 insertions(+), 8 deletions(-)
>     >=20
>     > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-
> lpc-ctrl.c
>     > index 332210e06e98..97ae341109d5 100644
>     > --- a/drivers/misc/aspeed-lpc-ctrl.c
>     > +++ b/drivers/misc/aspeed-lpc-ctrl.c
>     > @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file=20
> *file, unsigned int cmd,
>     >  		unsigned long param)
>     >  {
>     >  	struct aspeed_lpc_ctrl *lpc_ctrl =3D file_aspeed_lpc_ctrl(file);
>     > -	struct device *dev =3D file->private_data;
>     >  	void __user *p =3D (void __user *)param;
>     >  	struct aspeed_lpc_ctrl_mapping map;
>     >  	u32 addr;
>     > @@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file=20
> *file, unsigned int cmd,
>     >=20=20
>     >  		/* If memory-region is not described in device tree */
>     >  		if (!lpc_ctrl->mem_size) {
>     > -			dev_err(dev, "Didn't find reserved memory\n");
>     > -			return -EINVAL;
>     > +			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");
>=20=20=20=20=20
>     Why did you change from dev_err() to pr_err()?  You just lost a lot of
>     information that the user previously was getting from dev_err() :(
>=20
> I did this as per review comment from Andrew Jeffery, as we don't want=20
> to put this error for driver. It has to be handled by userspace. But I=20
> am still reporting some error here.

Sorry? What I was trying to suggest was removing the logging altogether and
just returning the error code. Not simply changing how the logging is done.

Andrew
