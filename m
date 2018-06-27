Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB95266EA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX8g8399"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB95266EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964846AbeF0BHz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:07:55 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39010 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbeF0BHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:07:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so175794plq.6;
        Tue, 26 Jun 2018 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bM58EDDy0l1qKkKMa5h7mF/SPV3QVQ4n20Wsld6Pjo=;
        b=SX8g8399iQFXPa4ZNdzUZtGaMKLN6AHzfpJVBcDDC4+7w+dcwtQ0MGIud790G0E95O
         +MfRux7QEg6fzHO/DCHRn+7iKRvvNrmhHjzguJ6h7pEAxYEp/kgIvaalP655SD/gQOKB
         Z0bd9xd8WnAYzisLYyfnCY34NOTwzJBvkJKWdYkFIRPCOUq5QG9+CCfXy2aACmvR83xr
         Xit69SdRsyrrBRgXFt7ivyuoahzL4NrLYO/17xwY3f4TShy4iyWnwhwe2WV2E0DjInUX
         GgjYnTXfgM+F7koiqIIb/rj7j+a2zwh1FfIhNu87Qpz4hgfE+4rFN46oZouO+Ofl7Prt
         eWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bM58EDDy0l1qKkKMa5h7mF/SPV3QVQ4n20Wsld6Pjo=;
        b=PsvoJs+J9AKuCHUAauJdmRGestW7Y7T26b8BB8Dk2eojpT/AKuDRaAweo+Tf8dDzOj
         llZ1zbQICff4VjjKPKsYLvGlx1E96zOoDQsvMKZUAu/GkOGAjLwDRO4QUlsjUaT/OxFo
         RRH/akdNjWav5AK7qXrVBOA10MC2IQJveOMMExcCKNoRNMKx70vj5KzLKBi4IOHawEzJ
         MQoWQgp4oY57jj5v4rfoMIACIcrgT6KXyMlT++oqApqN9m0OBQvP0T69BeVHiWiixkib
         eyDci2akRa8/AQ7H8NAkMX0iOGcUSEYJwIjAdUoZLBnuWAlDVu3hIoWpm8FUvMl8fMks
         t/jA==
X-Gm-Message-State: APt69E0YOwejDnv1/SNLoBcSNtqKITehIARZkfZgyf6VyYGYCVRpAMZU
        g9qWerqNTnXt3S+amXH5MU8=
X-Google-Smtp-Source: ADUXVKK4hu2nnePhJJ5T0SlO6o4Vkg9IzDT27K0FKgPwe5MiPeUMiHC36GEsUaTkUhQIsxxii0o8LQ==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11-v6mr3974419plo.308.1530061668838;
        Tue, 26 Jun 2018 18:07:48 -0700 (PDT)
Received: from localhost ([39.7.15.87])
        by smtp.gmail.com with ESMTPSA id s68-v6sm5623957pfi.85.2018.06.26.18.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 18:07:47 -0700 (PDT)
Date:   Wed, 27 Jun 2018 10:07:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] printk: Export is_console_locked
Message-ID: <20180627010744.GA10321@jagdpanzerIV>
References: <20180626183612.321-1-hdegoede@redhat.com>
 <20180626183612.321-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626183612.321-2-hdegoede@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/18 20:36), Hans de Goede wrote:
> This is a preparation patch for adding a number of WARN_CONSOLE_UNLOCKED()
> calls to the fbcon code, which may be built as a module (event though
> usually it is not).
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
