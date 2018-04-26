Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeDZELN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 00:11:13 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:39093 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeDZELM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 00:11:12 -0400
X-Google-Smtp-Source: AIpwx49rWwx+fCqKQgKgbCKlxUdP9WOT0yc7LLdUg/Ji/vk/4JK0ijePg5ghhaYwtrEm9JHivLLvEA==
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
From: Sultan Alsawaf <sultanxda@gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
Date: Wed, 25 Apr 2018 21:11:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed "systems without sufficient boot randomness" and would like to add to this.

With the changes to /dev/random going from 4.16.3 to 4.16.4, my low-spec Chromebook does not reach
the login screen upon boot (it stays stuck on a black screen) until I provide a source of entropy to
the system via interrupts (e.g., holding down a key on the keyboard for 5 sec or moving my finger
across the touchpad a lot). After providing a source of entropy for long enough,
"random: crng init done" prints out in dmesg and the login screen finally pops up.

Detailed information on my system can be found on this bug report I recently worked on:
https://bugzilla.kernel.org/show_bug.cgi?id=199463
