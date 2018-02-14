Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030662AbeBNOBK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:01:10 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43003 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030577AbeBNOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:00:40 -0500
X-Google-Smtp-Source: AH8x224+uFKdqfTdip5MIXsxmjnfSuEKDZcecxzw5LO4MN/ocaGgwxk0Un1If0STWDKrlNABnKIuKOG9u+1q8EzIE0I=
MIME-Version: 1.0
In-Reply-To: <1518514679-27782-1-git-send-email-geert+renesas@glider.be>
References: <1518514679-27782-1-git-send-email-geert+renesas@glider.be>
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 14 Feb 2018 14:00:38 +0000
X-Google-Sender-Auth: ipVV9kbGVIubO371KGX5LCzbweU
Message-ID: <CAPKp9uaqpgF=DjhYxQFUV97ps_1SdhhmhMkDBoT8XapvvunKDQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: Fix resume from suspend to idle
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 9:37 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When resuming from idle with the new suspend mode configuration support
> we go through the resume callbacks with a state of PM_SUSPEND_TO_IDLE
> which we don't have regulator constraints for, causing an error:
>
>     dpm_run_callback(): regulator_resume_early+0x0/0x64 returns -22
>     PM: Device regulator.0 failed to resume early: error -22
>
> Avoid this and similar errors by treating missing constraints as a noop.
>
> See also commit 57a0dd187956ea04 ("regulator: Fix suspend to idle"),
> which fixed the suspend part.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
