Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeBVKVg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:21:36 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35113 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeBVKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:21:34 -0500
X-Google-Smtp-Source: AH8x2248m2snDBWGyugC1ohGx6nVQ4RECoAEoI+ojea8bAa9tPAamXQYSJYTAf8JVDwyuW+igLcQ6w==
From: Marco Martin <notmart@gmail.com>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
Date: Thu, 22 Feb 2018 11:21:31 +0100
Message-ID: <1628582.nV6hDClBbL@phobos>
In-Reply-To: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MALeVN006077

On giovedì 22 febbraio 2018 06:14:07 CET Jeremy Cline wrote:
> Hey folks,
> 
> Commit 30323fb6d552c41997baca5292bf7001366cab57 (Support tablet mode
> switch) causes the keyboard on my XPS 13 to stop working. This
> particular model has a touch screen (which I've disabled in the BIOS),
> but isn't a 2-in-1 with a tablet mode. My guess is it's being put in
> tablet mode and that's disabling the keyboard? In any case, I'm happy
> to test fixes and provide any necessary information.

30323fb6d552c41997baca5292bf7001366cab57 initializes the switch to the correct 
state, in theory, it seems VGBS() is returning the wrong thing? could it 
report it has the switch and in a closed state even if it doesn't have it?
 also seems device specific, on my inspiron6352 if i go in teblet mode the 
keyboard keeps working until i fold it completely (which i don't know/don't 
think is something detectable at all from the software side)

can you test with the command evtest (if an external keyboard works, or via 
ssh)?, then looking at the state of the intel virtual button driver it should 
show you the current state of the switch

-- 
Marco Martin
