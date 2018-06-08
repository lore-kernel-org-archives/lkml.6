Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id t+BdINi8GlteZwAAmS7hNA
	; Fri, 08 Jun 2018 17:28:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6753D607E4; Fri,  8 Jun 2018 17:28:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqyiqfH4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E65A8601D2;
	Fri,  8 Jun 2018 17:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E65A8601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=emwesoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeFHR2x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:28:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46931 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeFHR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:28:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id j13-v6so21184353lfb.13;
        Fri, 08 Jun 2018 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r1SroL1oFO2xXT8Kv6Cqp8UhQoQzCZ95VI5vccQylU0=;
        b=mqyiqfH4NmtALN7xsU4aRRRlhy/OXCzt9X9EYPraZoCVf08F0HiihFouHRhQhBVDaB
         qSjLeiFcESYoUxPP2YAYKAF86Zw/mj/0ChLuiQWessvcWI0RabmWFNVuepCIPXi510M3
         9389tlk0/nnJv+b2uDDOeZqVfghNnHZE6muxgUrssmJlzwqAW81J7iBMCuC6CfqRo5O5
         XnpzL6Sd8Ck569iUlJSDJfCRWFxhOm7kLItoZbZiLbs135OPLjNgrM9mjuPunBLL04Wk
         PLACIq45zjQ50k8yi3GrTG9LsKyfBQY6d9NwYmx+3QEF2d+AZ/7VRRUyJOnfTDZLDjY5
         fyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r1SroL1oFO2xXT8Kv6Cqp8UhQoQzCZ95VI5vccQylU0=;
        b=nBf3/GSQyXlGCQDfUQoP6ziITMG+qQpzUso8LuW3X/BxRMQHADkKlgaLw9lzTR9UZ+
         lcFB7t6N8kYvuVaN0Y5JSLQ+oAsR9484i3WEOEGuyRINJxNWudFeU5U0W02VlNfn5XHB
         x0bPzgND2J44j/Jto1iUFRmLy9XO9lykttpxfTSIJ/5mVhV2hnCWKRy3xhUH5VDYgfHm
         vXY+m6+UevrqJlzyWoSsfuyiEbuFfb1NHq94PCqWc7BglGD05YLmK8oDjz8RypvPvQY8
         CI7Yu3leOe8E6PfQdAsSDDSUy6YI6EH8ZzgXphDofV1fP+Gvbscx6qpsgTU7mhgecdpT
         j1Cw==
X-Gm-Message-State: APt69E1w4qIy5ZJkpzk4BmT4GHWv7i8WT/4Npes9bW42ZywVdSDtUc7P
        XJDSpPeBAhPb2Ms/K6HGqKE4rUeCoUjGVHndYXRiZg==
X-Google-Smtp-Source: ADUXVKJfdnwrBloGA9sTpr1aucRwuLY5YSpC/Er2Vg9+KfYIdscCttyqkhduMYxBslZF8O7FS4UnP1JmjbyOaGR2KUI=
X-Received: by 2002:a2e:1790:: with SMTP id 16-v6mr5325185ljx.101.1528478930051;
 Fri, 08 Jun 2018 10:28:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4d46:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 10:28:49 -0700 (PDT)
In-Reply-To: <73c3d354-8aa8-e0c2-c4c4-658a65154394@bitmath.org>
References: <40764439.8xGR6LbaWR@positron.chronox.de> <2305311.UGlXl2onVb@positron.chronox.de>
 <1566223.3I8hjEaRec@tauon.chronox.de> <2373130.0OS7LSYeBT@tauon.chronox.de> <73c3d354-8aa8-e0c2-c4c4-658a65154394@bitmath.org>
From: Marek Wyborski <marek.wyborski@emwesoft.com>
Date: Fri, 8 Jun 2018 19:28:49 +0200
X-Google-Sender-Auth: i3tNuDy5VOqxZ08F5pyhgzQnEVc
Message-ID: <CAMBc8znYhLsQ3EXa_H7L-+ypVzOSHiKUQqnR6gSCfjOLkdCp8g@mail.gmail.com>
Subject: Re: [PATCH v3] input: bcm5974 - Add driver for Apple Magic Trackpad 2
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephan Mueller <smueller@chronox.de>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Henrik!

I think you have been absolutely right about the MT2 support and that
it should be in hid-magicmouse and not in bcm5974. The more i am
working on the driver, the more i see your awesome work for multitouch
in the kernel and in xf86-mtrack as well. So i try to keep close to
the event reporting in bcm5974 and added the MT2 support to the
hid-magicmouse with USB and bluetooth support through the HID layer.
It already seems to do the trick, but some people are testing and i
will have to clean up the code. Then i will send in a new patch until
end of this month. It would be great if you could have a look at the
new patch, when i send it in.

Marek
