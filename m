Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF01C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547483009;
	bh=SrpWBOK+sfL7tNiX4drUB7zErm7kLiARyrLUuG9ICAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PQDj/3E5qSv77+ptz2p8ybkOE0LBAqkJDKdYwzN3sK/2Ph6k32NqbEF5olgGz8McP
	 vwLBJ1ZLyuyRHhnmXW/NIPmTUk/It8bU5QV9c8AHhWCSkWtBNL03sVDdGN48FUg11e
	 Z/qCEhnSDAhqOJWYbQYHS/8mRALSRsx8n0Wk84Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfANQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANQX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:23:28 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A335920873;
        Mon, 14 Jan 2019 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547483007;
        bh=SrpWBOK+sfL7tNiX4drUB7zErm7kLiARyrLUuG9ICAQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J37kRVDYBAdtAMpifj6PNC6xP9CYMS1msOfxVjbiMXiw26npOaQ15vq5GARCTHWvd
         pg6NmfBd81hLRyQuIKgTC9Np6jwTda9odXjWdTh60v0sZnNplL2gltw910TjXogb9b
         9kFhXVOXQ2eGm2wpAydWAA1f6lolxRZ6KW5uPed0=
Received: by mail-qt1-f173.google.com with SMTP id u47so27142389qtj.6;
        Mon, 14 Jan 2019 08:23:27 -0800 (PST)
X-Gm-Message-State: AJcUukc//4zeZd5JVf1dSMypNvE2wX3oHfdneemqG6flcKH2wekLC06V
        ESxjAg4aFvhh19PPvGrKbrX7MVQkBcF0cB+ZSw==
X-Google-Smtp-Source: ALg8bN4POydrDyOKTQj1MLDtH/EcAmUkuUeehIdr/mcCrLtu5JrBh0VNbkP6iJ+inGbitF+tDLJP2qa/j9zVrce84cA=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr23674239qtd.257.1547483006898;
 Mon, 14 Jan 2019 08:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110222017.6390-1-robh@kernel.org> <20190114093022.hjouckoss2zemefg@verge.net.au>
In-Reply-To: <20190114093022.hjouckoss2zemefg@verge.net.au>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Jan 2019 10:23:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd_kHi+XU7_oe0upg1iJT2rjjEup3YpyrDQA-OhkgKTw@mail.gmail.com>
Message-ID: <CAL_JsqJd_kHi+XU7_oe0upg1iJT2rjjEup3YpyrDQA-OhkgKTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert snps,dw-apb-uart to json-schema
To:     Simon Horman <horms@verge.net.au>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 3:30 AM Simon Horman <horms@verge.net.au> wrote:
>
> On Thu, Jan 10, 2019 at 04:20:16PM -0600, Rob Herring wrote:
> > Convert the snps,dw-apb-uart binding to DT schema using json-schema.
> >
> > The Rockchip and Broadcom compatible strings were not documented,
> > so add them here.
>
> I believe the documentation of the Renesas compatible strings is also new
> in this file. Perhaps it would be worth mentioning that too.

Ah, that should be in patch 2. Will respin.

> In any case
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
