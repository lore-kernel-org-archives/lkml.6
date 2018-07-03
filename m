Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3157DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401E2170A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk36+k3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D401E2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeGCGec (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:34:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40660 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeGCGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:34:31 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so644710lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D103nx3KBYQWb5kwA6VW/dkt0mA2sYSO7pw0w3EcmI0=;
        b=dk36+k3CTXvZKAIXR6mtrWEc0LToc75ilc+sBXhBkqRsL0y1u4DawbuOgrAYfNwr86
         2+eFKZwzXlCSc44B+Ny0VNpc4np6DKTy5U7kVxBkkkci1zfAhphULzuOuqnY8Z2lScnl
         5q0JdyufAJaYU8fjAU5CP/1blHvQ1cs87Aj9iWaSZXQRxfhuJI1FwK99Asvjx+E0UDlZ
         SZnl5/uKCe/fzTDu5PtJ6gAGtmWa0eXtpRX1ivdfwxWLvjzyWStF2gyKaq/D8ml8xQoe
         WBZiqzZ05bnnOAXHVk50kNWsPpf0/3rhWdNevKIkmO2cYiE7+PTcW3EZlZzyiiQn3BP/
         v05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D103nx3KBYQWb5kwA6VW/dkt0mA2sYSO7pw0w3EcmI0=;
        b=Ctgs66U97yji1P5fM3oDN5rB8vug6xIomLz0ZGY3lprwdr3wk8zC8dBKOHFFOmL02C
         fySTEuJgRvyB74jmTbOHN0nd5nqfjFw1GZ5W/I48l3DEyVjdmsLgpmYuz8XX5+J1QPW0
         4EtVDuGhFAps505IIzn57f3DTNWG4Wfz0S1roGVyL+YX6AOu2xQuDt4SRr9vR/Y7GM9W
         IBROeXjSDGbKKRonwmjpCUNrC5Jru8ZUemO2u6vWcAPnPcVEfcYN46jHmtaW87XVXP/m
         vZp/+8mhxKoT4/spzM2rgD+mIT01nWh5rmcHVbMoVVxEVEuCZxjmPSQrRicNgAXlewXR
         zBWg==
X-Gm-Message-State: APt69E1D63Ctlj9V5/9g1suHfQTuLmJRm5PK4mGPXDPoaX7YH6s/h71v
        sTHoJ9j26UXGLUQgwyOohUAHOcMpkMTUA2lYro0=
X-Google-Smtp-Source: AAOMgpc4OmP7AWe+cPD2dAarmiuHtyMLByEQMT4aJ8ILlcLw0mplbnc7BRAp6b29fXpllOEw+O+wivSO2Dg9md5QpuA=
X-Received: by 2002:a19:8f8f:: with SMTP id s15-v6mr10753814lfk.96.1530599669947;
 Mon, 02 Jul 2018 23:34:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 23:34:29 -0700 (PDT)
In-Reply-To: <20180703062857.6fdjg5trv4a7z5zl@sirius.home.kraxel.org>
References: <20180702182728.GA6015@jordon-HP-15-Notebook-PC> <20180703062857.6fdjg5trv4a7z5zl@sirius.home.kraxel.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 3 Jul 2018 12:04:29 +0530
Message-ID: <CAFqt6zYmzjJGY2-HiUxdRf1ntw7y0MxVC8V+ewS9URDVdEQTrA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: virito: code cleanup
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        SUMAN TRIPATHI <svptas.linux@gmail.com>, ajitn.linux@gmail.com,
        brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 11:58 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, Jul 02, 2018 at 11:57:28PM +0530, Souptick Joarder wrote:
>> The fault handler code is commented since v4.2.
>> If there is no plan to enable the fault handler
>> code in future, we can remove this dead code.
>
> Indeed, but please without tyops in the $subject line.
>

Ahh, typos. I will send v2 after correction.
