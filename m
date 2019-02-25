Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6A20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7dpWB+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBYTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:17:26 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57237 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbfBYTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:17:24 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E26522E6A;
        Mon, 25 Feb 2019 14:17:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 25 Feb 2019 14:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gKquis
        yiioxBvkPS7J4ggVN8hUbZ4hrC6FqGl0JrSDA=; b=j7dpWB+YYK8nTNjXPmp6aX
        BuxAJ6WXM9eBCxg/yNw5cWYr3k/o/C0+V56yfTf/e6km4BxtOWHMTCTNSJgW9g5a
        QJFuae8ryDunDL9PUgEWX6wlCF7qdNzm+QT+MO28/uARLmdUJNXM9UVDG4b0VKRn
        Hm7N24MHIBhqeVn3pMJOSWJ9ieRMnxJecWna0HRK2TONxfTfLBR0MBVaRxCLyxQ3
        R5WYepKmAm7a528ApJAsmrckGZSMQw03y3RwDKNDwdPq966owsrMXir3/bFThrMU
        KM3eSKGcjKFWWpnJ4rWmiwayedomKivmmwVmMzBF8XRy2zR2CsBrkenEcvD4GqZA
        ==
X-ME-Sender: <xms:QD90XKp1KWDJU-3yeXVl4FLMKfSzz7o3nxYBNYsf9wTIr89sP3O0tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudejgdduvdegucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucfkphepje
    ejrddufeekrddvgeelrddvtdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QD90XE_CwNcaMhGQUzNAVIlg-Q7X7yGzd2nfE3YlTismZL3AC7B9Mg>
    <xmx:QD90XB-_eL3IExcRRWWz29yIlpx0ozrPQib7Ys6E07zjjKfhChc-bA>
    <xmx:QD90XLvZRhOd_XSrXevE1gU9fWnMyzpcVLxMSQdnE28a4wFWJgMQAg>
    <xmx:QT90XMo8T5H8z4VTc0-2C0Zy0pvIVQZvTbt8Y09YfrtnYqhItI_OJg>
Received: from localhost (unknown [77.138.249.209])
        by mail.messagingengine.com (Postfix) with ESMTPA id 230D0E4650;
        Mon, 25 Feb 2019 14:17:19 -0500 (EST)
Date:   Mon, 25 Feb 2019 21:17:08 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum: acl: Use struct_size() in
 kzalloc()
Message-ID: <20190225191708.GA30453@splinter>
References: <20190225190132.GA23478@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225190132.GA23478@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:01:32PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = kzalloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)
> 
> Notice that, in this case, variable alloc_size is not necessary, hence
> it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks
