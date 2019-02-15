Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16150C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69A1206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550218877;
	bh=T/J91P7CAp5uWhAgEt7jr3HpvbZUJ9RPqKxigbKRjN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+8CoVuPn5nDqj//6FTFBUxUbyzAFXe9YrPYByz7AoRa1sBODFdT/LyjdGQpffwSY
	 dKMi1iwz825w8AcPArJyU6Uf/ZqUDOKQqAN6WGpQt3oFxrKrmR4WJyUj342ZyQ8NVm
	 XttEN6jPehq2msZhlD3aBBkom9vvhcHV/YLTc8Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfBOIVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:21:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45134 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfBOIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:21:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so7573936ljd.12;
        Fri, 15 Feb 2019 00:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMHxGfmLS3hHu8Id/q1pErDtAM0OOmwu0y1rLEu6Bhw=;
        b=mhCOqEe8aZ0QflgKBB/Gm0/zfxLJFE1m7tH1agA9JwdxxjRMOklQThu5hAjouuSUo1
         Ln/zHMUmR5gNw3Ja7AOLAkPd2OoqHEizeV224OsP5UbFMUDUhPEzDIOsEkYV1aMCa24E
         ULMi1JfqDQauzr5X3GISb2UTndoKmUMnQYrkmY1KPPwSy2wUnm6hwa1zLSW2sRJC2dLq
         hlrAp1CuqZQo69xhoOuWbndmbN1CZjdrFslMhLR6AZ1gD7H9fLvM2GON60iSChV6MYQr
         n4Phr5lUEMz2JZxSBxCKvp1+KmhkJUkMB+SYOYiXX/5y97s1fuGo3+ioNBFPIIJ559W5
         TxZQ==
X-Gm-Message-State: AHQUAuaUHmqIt1ss7PBhbncLbHmlk1bqXLsldmNIq5tzNY93MXRUyoXT
        tJGGE1BVxNROWphkkIlXRdbQTyQt
X-Google-Smtp-Source: AHgI3IYHvUwIL8mluEOE6pBk5TiiqtDmEN9WLDGTGwQPwpGljR5fxESObYhRJjEfng6jQYoLDogZKQ==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr4824502lja.44.1550218859429;
        Fri, 15 Feb 2019 00:20:59 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z88sm1056800ljb.10.2019.02.15.00.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 00:20:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1guYjs-0005hU-Jz; Fri, 15 Feb 2019 09:20:52 +0100
Date:   Fri, 15 Feb 2019 09:20:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add ID for Hjelmslund Electronics
 USB485
Message-ID: <20190215082052.GM28278@localhost>
References: <20190214194533.15111-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214194533.15111-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 07:45:33PM +0000, Mans Rullgard wrote:
> This adds the USB ID of the Hjelmslund Electronics USB485 Iso stick.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied, thanks.

Johan
