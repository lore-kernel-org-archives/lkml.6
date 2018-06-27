Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02ADC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6182D22EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPxdzsNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6182D22EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934596AbeF0BJg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:09:36 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43836 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeF0BJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:09:34 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so157741pgw.10;
        Tue, 26 Jun 2018 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMHlQkdTT3pceINt5XbDeVzl/NwE96mkEr3S66mTl/4=;
        b=fPxdzsNglsH+sQYxvEudT0skft6gz5vEIt1j3hScmXVg28V38HFig77AtXfRVsMsTA
         SYcTuUj9E8XxZK/UFKUMEQ0hZDT6jx8btfUk6t0xvPCK6U0i+EAK1VvryWUOyRwmjDBp
         JMFafELLbv5k/8QUAavcUiatSHC1sIPyW+t26ybSAGZtaf8fwERHBOdc+WoP6fdY8gv0
         g3Sd8uQ2Xbm2jXgp8wAJDO2ZdOVbY4P10cD1QhynmeZDpFhyaPZVv2jqZs0I2hKEepQ4
         GW/fqgHitFUxmTT7pv6bi5xEYKNK/j5VbDpm8YCXunD9CJbJANC1si4wXzeIhv9bUQyW
         SO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMHlQkdTT3pceINt5XbDeVzl/NwE96mkEr3S66mTl/4=;
        b=U4HoeQnKomPNvCErQ103Qt4+w1jbOn9xVwL7xtR07765gl/jw3Moqbh1eqGd0duvJC
         S9Zl0KRiP7jcEGt7mfskFDoV23GjnwQ40vJPPId8m8ZOqkGWlZ29BU7io30Hby1elyXr
         wr3Z+bmiJeOLegpMrv2ocGoSQIJlpiHxSWwkYo8CiVmJCmITZsSLdj3Vd7/kVlyzGiN9
         AUTxIW5Sp/9vpBewaaoqR+sjw43YkcOIZancuZlT5QX0Om1ugQqN1mm/uC9wSeqR578C
         thdxal5HNbkwyAXNQIiHXzlwYbngvTtrVGSOwNRhEimTfIEyPDBz4rg8mHnruBguv5Jv
         iv0A==
X-Gm-Message-State: APt69E0TXfmqr2KK2A/tyBuDq+2sU1/j+KT0FSdwKCBgTFdjCX5vGgOA
        W0qpgQMZIo+6a4MYyq5A1B0=
X-Google-Smtp-Source: ADUXVKLHYo3g4UO6u0bMAdFnAal3LwqTKUdg10VilP4N3YPD9W/DDt98SiZZ4QoSMQoxf4uOsDgo1w==
X-Received: by 2002:a63:7e1a:: with SMTP id z26-v6mr3261293pgc.278.1530061774158;
        Tue, 26 Jun 2018 18:09:34 -0700 (PDT)
Received: from localhost ([39.7.15.87])
        by smtp.gmail.com with ESMTPSA id 74-v6sm7914117pfj.127.2018.06.26.18.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 18:09:33 -0700 (PDT)
Date:   Wed, 27 Jun 2018 10:09:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
Message-ID: <20180627010930.GB10321@jagdpanzerIV>
References: <20180626183612.321-1-hdegoede@redhat.com>
 <20180626183612.321-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626183612.321-3-hdegoede@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/18 20:36), Hans de Goede wrote:
> Replace comments about places where the console lock should be held with
> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
