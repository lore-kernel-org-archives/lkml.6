Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755551AbeEaPrz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:47:55 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39105 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeEaPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:47:51 -0400
X-Google-Smtp-Source: ADUXVKLXpHoMjd1x1UOk7kb864GEzO2KI6GWmZ6I5IOfzJDThfPT4eRQ/m0iQ8O8z1B7So+z0eGUiw==
Date: Thu, 31 May 2018 08:47:48 -0700
From: Tejun Heo <tj@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>,
        Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Subject: Re: [PATCH v2] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
Message-ID: <20180531154748.GS1351649@devbig577.frc2.facebook.com>
References: <20180531112107.13778-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531112107.13778-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 01:21:07PM +0200, Hans de Goede wrote:
> Commit 184add2ca23c ("libata: Apply NOLPM quirk for SanDisk
> SD7UB3Q*G1001 SSDs") disabled LPM for SanDisk SD7UB3Q*G1001 SSDs.
> 
> This has lead to several reports of users of that SSD where LPM
> was working fine and who know have a significantly increased idle
> power consumption on their laptops.
> 
> Likely there is another problem on the T450s from the original
> reporter which gets exposed by the uncore reaching deeper sleep
> states (higher PC-states) due to LPM being enabled. The problem as
> reported, a hardfreeze about once a day, already did not sound like
> it would be caused by LPM and the reports of the SSD working fine
> confirm this. The original reporter is ok with dropping the quirk.
> 
> A X250 user has reported the same hard freeze problem and for him
> the problem went away after unrelated updates, I suspect some GPU
> driver stack changes fixed things.
> 
> TL;DR: The original reporters problem were triggered by LPM but not
> an LPM issue, so drop the quirk for the SSD in question.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1583207
> Cc: stable@vger.kernel.org
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
> Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
