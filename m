Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232C2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549930393;
	bh=0NyI7xelrYIKd8TIGJZqApl7yTL6btDM9a3p73E1srY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q6svDb8eKruB5W4Uin2v8T0Sq9Cg3Dm4DFvs0zrFnIkXbbhCmgSyMjg/Jgk6ObGL3
	 jcQnN/4vM38DdUqnj08qS9QDnyveK2+MmMS2CUjvPgdR3vKXu12DIU4ZuOyocM1lk5
	 kL0fCNcTj4VYpdeEmYjos4rMYXjhosUg3ljMJyyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBLANM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:13:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39297 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727722AbfBLANL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:13:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F8B522D1E;
        Mon, 11 Feb 2019 19:13:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Feb 2019 19:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2f/onKj9On8Nv2UiC
        W79f6zxFXSlDfwL8Zal42Vs35E=; b=1JcAdh5hnbUeHv6BGUcTNP7/5RRUYXh7g
        KsxjgoNFzRtU9V5Hq0l65JxN6V3lQzMeAFmjV3saf7Pl650XNWjaMPd+n1o41RUq
        skZ3IZJTVbou0UHNEiFpDbhTSJFsY8pUyawKBiTDLf+tR+AFlIPbe3h851nuH+TA
        AdMFRUxfBhOX17FiZh5/IHj53/J1D0HX8WBnkcs7vGFGHi+FpwXrGxYIEgy4YFn+
        TV8qQBIdWaj1udgLaw7h8aefROy53w4R6sHr6/3oP797MdtX+hME8ROWF9kGqb+T
        68JRFCsNMuFv47TGukKDFlOdG6qVO15B57JAnOsGHBpyn84HUoELw==
X-ME-Sender: <xms:lA9iXBr6MQr15em6hyR7obc-cN56_aAQOaxQAfHPtBlrczLqwz0BHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkof
    gggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdf
    uceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepuddvgedrudejuddrvdefrd
    duheenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:lA9iXH7OF_vFCzj-DP1Xsbs6qUnAvUSNNz4SdqGh4wIoNhiW-HuN3A>
    <xmx:lA9iXJMMe66ou9C61hibt2Xspk6kgX6T6wPPCFnVdal9nsHDwJlAJw>
    <xmx:lA9iXBN2M_idT3zhL2OvYLhoTZKaZbR0_KZ_zj-wVkbqrgyJxo8SvA>
    <xmx:lA9iXCwaH86SqkZqPjSCI6FVzDrz2ed1MWI32-i3LdsU3J4IrDlYXA>
Received: from eros.localdomain (124-171-23-15.dyn.iinet.net.au [124.171.23.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12399E4412;
        Mon, 11 Feb 2019 19:13:05 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] tools/vm/slabinfo: Clean up slabinfo -h
Date:   Tue, 12 Feb 2019 11:12:15 +1100
Message-Id: <20190212001219.27769-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is a simple patchset cleaning up the help output message for
`slabinfo`.

All patches include Acked-by tag from Christopher (patches were viewed
and acked off list).

thanks,
Tobin


Tobin C. Harding (4):
  tools/vm/slabinfo: Update options in usage message
  tools/vm/slabinfo: Put options in alphabetic order
  tools/vm/slabinfo: Align usage output columns
  tools/vm/slabinfo: Clean up usage menu debug items

 tools/vm/slabinfo.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

-- 
2.20.1

