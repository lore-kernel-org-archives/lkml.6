Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BCC31686
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FFC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548090643;
	bh=qDPFEDsWraJr4Cb6PqCIVk10em9q+cqXPbV2PXWsQ4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h2elCV+m2wE71M/ynhHS1OgjNWwNHu/zGZlzC0y2b6wUaALEHZ7XiZc+cRioILalH
	 nE92AU6h6KGe+ujL8wsElTIXAUInb0/us0IwBRx8DctNrBLzc79KDEZuzj7F6VdDCe
	 8jRvpMbzd0ZQyrt+r/sNAK2cDWEwvJi/P45Fe5I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAURKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:10:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40371 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:10:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so21137232oth.7;
        Mon, 21 Jan 2019 09:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9f3AcdeKbIIxo8MjXtpjRk0EhYAlYFtGMddivzLvCdo=;
        b=pXGT5lKW8KPVa34H2vJWXdeILvlP6wT6tb4jIp4NVPoFa+fzsuoRVmDToj4IyQwcVN
         HBdSqWLtH65bvmhPBMejzN8By5eONjek7CkMx8/XlT6V9ygCA6J/E87B9BbGNUeWVXcl
         xTWSZDmsRtqz1HrTrvd6Aw2enyosEtFugQtdP4tKx/OeKP/ri2FY1rA00JhCZNUC8L2R
         q/huv6ihkNPxkUaagTNJEa0uqfUyZLS0ckAwhlS0/4drS3uSBu0anQYyNbzLgTBsmtBn
         D/G9GPttWnH+5CI2SjYa7YNcDUTviF6cb62a2LFwuT/IBF+epv4joE6Nx4T0jQZk3jr+
         Jh2Q==
X-Gm-Message-State: AJcUukeKVAB3Fq/v2ILEW3v7QHbhnbW/+dbpw7fokJ1Aa30hjcRhrqvt
        K432mTY59tPfSwpoaSgc95u+7wc=
X-Google-Smtp-Source: ALg8bN7wt6lPH8gm0ZHSbaKj1cMB2paHXusqNJTnNL/tsQHW4Q5pO7QvouD32MhwP3wBR8080ReSLA==
X-Received: by 2002:a9d:4:: with SMTP id 4mr21042946ota.174.1548090641033;
        Mon, 21 Jan 2019 09:10:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm6017517otr.30.2019.01.21.09.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:10:40 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:10:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     panfilov.artyom@gmail.com, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: rtc: add ABEOZ9 support
Message-ID: <20190121171040.GA3603@bogus>
References: <20190117184755.21179-1-panfilov.artyom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117184755.21179-1-panfilov.artyom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 21:47:54 +0300, Artem Panfilov wrote:
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
