Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeBCQ3B (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 11:29:01 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36172 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeBCQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 11:28:52 -0500
X-Google-Smtp-Source: AH8x224xjwvWAp9w3I45uyXyb0vGdDeEiBKfq3Xdp2V6d296ILMN8PNJaIWLpbcaVwqJZQzckPnML3l3nKG29lJA28E=
MIME-Version: 1.0
In-Reply-To: <1516258057.410.55.camel@sipsolutions.net>
References: <alpine.LSU.2.11.1801171448510.5433@eggly.anvils> <1516258057.410.55.camel@sipsolutions.net>
From: Kevin Groeneveld <kgroeneveld@gmail.com>
Date: Sat, 3 Feb 2018 11:28:50 -0500
Message-ID: <CABF+-6Ur0v=dbyXCFxWS0BeAJuivcANFeRr=g78DggWEL22H9w@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: stop demanding lots of new stuff
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hugh Dickins <hughd@google.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 1:47 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2018-01-17 at 14:55 -0800, Hugh Dickins wrote:
>> "make oldconfig" from 4.14 (when CONFIG_CFG80211_CERTIFICATION_ONUS
>> is not set) to 4.15-rc, gets into asking lots of new questions, and
>> configuring in unwanted stuff: I'm unsure of my Kconfig skills, but
>> it looks like CFG80211_REQUIRE_SIGNED_REGDB's "default y" needs to
>> be toned down when we don't even have CFG80211_CERTIFICATION_ONUS.
>
> No, this is wrong - we want default configurations to be able to load a
> signed regulatory database and validate the signature.

I had a similar reaction as Hugh when I recently updated a kernel
config from 4.14 to 4.15.  I barely understand the kernel config
options in question so I don't really know what is right or wrong.
But it seems strange to me that when you turn off
CFG80211_CERTIFICATION_ONUS in menuconfig that the options which get
hidden are forced on.  When options are hidden like this I assume
(maybe incorrectly) that they are dependent on the option I just
turned off and that the now hidden options will also be off.

Kevin
