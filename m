Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764E3214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RxLBoPI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfA2Qpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:45:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37715 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfA2Qpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:45:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so16516224edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sP4zsk+iKoUTk2N5HbOFgwJnJU8n14GmzC82yJEnKnQ=;
        b=RxLBoPI9Twh99x+oJKFq1IhAfu9UBjlyjAbyxyVZs0CDAFgV+Xo2q4XNpbDEu3kAyY
         KHIYGmuPsm47UTtHs9W0vcNK3j+4MqjCiT3fyFpAh67RMMMWcS9UxuLyCYCXtCTKY9g7
         PIk2HsUmX5CgtTmiaQZXX8XcadQwNss/FAilw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sP4zsk+iKoUTk2N5HbOFgwJnJU8n14GmzC82yJEnKnQ=;
        b=sFoA9+eBjXHPNkH332ILxZVxKLFR6Tf+7djegOS3oEMtuFShxb7NIiq/VdoGanFVpF
         /QibkhxHine4f72U+1U2t3EkW/tM/M1UHgjIb6Ky6XlL0n8gh3E2osqzJDjeaF1t3xQ/
         uFyDLcb3WyvLW7a/rYV3Ne7mQl9kgF2XrlltJHUMBsD+mM18dO4Q2ZoRVIANNk7qMcyQ
         2lMDESmSI6NU9hxPs0ItRsLcwWOPxuClTH74ggtVqxmWp3ZEN+tF0baDZW4MtNCrq9x+
         O++uhUZL0F+ps5Q/AtzNHBfkjYO0EpusOI1RMbu+PAi3fbiV5jmd/Xlxyk/SEk8gG+e/
         nKWA==
X-Gm-Message-State: AJcUukcCQ1RzI4jwkRGX8QPNUkVvk6YVRCQYmqAkbzV9CBLuTwSfqCry
        VcSYk3aYAfskir0aUhi2q2rCNg==
X-Google-Smtp-Source: ALg8bN7xPR77VqW8t1Cvn4Kg5GV3i4yUKLewLzUep3J3sK9V8XIXt+CPgz+YlDQXpbkWRxz6Usw7SA==
X-Received: by 2002:a17:906:5053:: with SMTP id e19mr7656419ejk.9.1548780353384;
        Tue, 29 Jan 2019 08:45:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j4sm14499889edh.69.2019.01.29.08.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 08:45:52 -0800 (PST)
Date:   Tue, 29 Jan 2019 17:45:50 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: display: add binding for Innolux
 ee101ia-01d panel
Message-ID: <20190129164550.GU3271@phenom.ffwll.local>
Mail-Followup-To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org
References: <20181113124205.29319-1-heiko@sntech.de>
 <5825168.ASgtykK0VC@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5825168.ASgtykK0VC@diego>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:37:23PM +0100, Heiko Stübner wrote:
> Hi Thierry,
> 
> Am Dienstag, 13. November 2018, 13:42:05 CET schrieb Heiko Stuebner:
> > From: Heiko Stuebner <heiko.stuebner@bq.com>
> > 
> > This is a panel handled through the generic lvds-panel binding,
> > so only needs its additional compatible specified.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> just pulling this pending patch out of the woodworks again too :-)
> 
> Thanks in advance for considering it.

It's a panel patch, you have the review from Rob, you have commit rights
to drm-misc and panel is maintained in drm-misc. There's nothing blocking
you from pushing it, just do it :-)

Cheers, Daniel

> Heiko
> 
> > ---
> >  .../bindings/display/panel/innolux,ee101ia-01d.txt         | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> > b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> > new file mode 100644
> > index 000000000000..e5ca4ccd55ed
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> > @@ -0,0 +1,7 @@
> > +Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
> > +
> > +Required properties:
> > +- compatible: should be "innolux,ee101ia-01d"
> > +
> > +This binding is compatible with the lvds-panel binding, which is specified
> > +in panel-lvds.txt in this directory.
> 
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
