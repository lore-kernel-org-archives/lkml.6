Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695D9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3138D2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWBInFJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfBBGrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:47:13 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53631 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbfBBGrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:47:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AD2921F0C;
        Sat,  2 Feb 2019 01:47:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 02 Feb 2019 01:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=VqtZCAM8aMEkU1Vxv8nZ/3avC5flqPGIuAVx2UccI
        Vs=; b=KWBInFJ9cP8LxdZoWAsVpQlQsnijmQXHeAAxS6i9jMbgd7gr1tfNmQD9C
        BX9GJ9EQQWIQ6RcHNO/h4HxbuDt1oqkHnod5YLzg+x6XjX1kyB4HiMqFiPz6fvPi
        hbF7FB/Rax9TJw64b5tjeaooXasMJyxvpyOg2yjhoHHkRss2xs9RBibMTO/dxM1t
        JT14vc+TDXdbRorDw8VOAf8Kzd5me7cZhRzjBZD55duDLQQtTFd9THk9N81ScF6e
        tUIzdOxIVHPSIh63Zb2wgWRXGYACC+qXiV+GkOqtaivHleb0e4+Y3+UA/Vnv26Us
        Dp7ZS1lJPTag2oqeDRCNpxz1yI9JA==
X-ME-Sender: <xms:7jxVXGKFOWtOnOi-wfKaYxrnCKvBoev_EoUTfqT1t-4MPiCR_GZQVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffg
    ggjggtgfesthejredttdefjeenucfhrhhomheprfgvkhhkrgcugfhnsggvrhhguceophgv
    nhgsvghrghesihhkihdrfhhiqeenucffohhmrghinhepshhouhhrtggvfhhorhhgvgdrnh
    gvthenucfkphepkeelrddvjedrfeefrddujeefnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpvghnsggvrhhgsehikhhirdhfihenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:7jxVXCtqJyryU6Sf7c-QpzrMZjPz6dXKC7CD3_x5z0vEDcuuWvszug>
    <xmx:7jxVXD1Wr8afRVXmGI4bpe48knzggg5dA306lgfHdNha9MBj9lYErw>
    <xmx:7jxVXCMXGsnu2QWpKHIR7Cx8saBOGXS4NYEBYRYrvM505VtCaMyzIw>
    <xmx:8DxVXPIXX5EOq9aRuBgST90HwtkUCZacIOyBbE4uop4XDD5TppRacw>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id C55F1E4078;
        Sat,  2 Feb 2019 01:47:07 -0500 (EST)
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
To:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190201004242.7659-1-tobin@kernel.org>
 <01000168a6e8944d-b8e72739-2611-4649-a8d2-304b98529b7d-000000@email.amazonses.com>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <ca008d08-0041-5277-e562-5212783ea6be@iki.fi>
Date:   Sat, 2 Feb 2019 08:47:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <01000168a6e8944d-b8e72739-2611-4649-a8d2-304b98529b7d-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/02/2019 4.34, Christopher Lameter wrote:
> On Fri, 1 Feb 2019, Tobin C. Harding wrote:
> 
>> Currently when displaying /proc/slabinfo if any cache names are too long
>> then the output columns are not aligned.  We could do something fancy to
>> get the maximum length of any cache name in the system or we could just
>> increase the hardcoded width.  Currently it is 17 characters.  Monitors
>> are wide these days so lets just increase it to 30 characters.
> 
> Hmm.. I wonder if there are any tools that depend on the field width here?
> 

It's possible, but it's more likely that userspace parses by whitespace 
because it's easier to write it that way.

At least procps, which is used by slabtop, is prepared to parse a cache 
name of 128 characters. See the scanf() call in parse_slabinfo20() 
function in proc/slab.c of procps:

   http://procps.sourceforge.net/

Of course, testing with slabtop would make sense.

- Pekka
