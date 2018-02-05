Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeBEPNS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:13:18 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50671 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752919AbeBEPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:13:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>
Cc: nico@linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] LTO: two more fixes
Date: Mon,  5 Feb 2018 16:12:51 +0100
Message-Id: <20180205151300.539874-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:qc1f7xY8WhZjq4iltIeBnhX3ShKMAAdg6vwHTjs0lCEakQRnVeN
 60J+814utnZk3lDPmfJ6a8DrTFRdfSsVcY/K19nSunPPBnOHBmdgWjYH+R5aCljx0rR/MHZ
 5ggLqIrAcdXhkqhDAmNsi0yzsZNRmYTG2gh4C8F58zaO+W3yalDz0L9Ocy8+md2LYHaWpBA
 GzEO9D/LmnQbrvjUakyJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qm+OD406gJo=:G8YjS/WiVwcenBVimJuFof
 5feprZKH4uGQEymRnATQI+JAQ2+JxAiQUrDlLugsSVd8oE8yyVpvJ5Dna6QGv2x6nydI7cmCn
 p9pW9rTTZ3ZDs8FyI4UGNIqLohp+EotAr23IIHlAqzEsRsRSheOvB9wBfTga0W1d+EqsPxEbU
 JEBJd0eHg7n/M6UBKlOdy2s7L6RZeBIFIV4DE1DRpYESr/ISFdzBxXPkJ5VJOcXuB9FrYkb84
 +JvrJSsbE18BX97aLjmhxsIcdnyffFV8SeHlWKFJpOFW2NrOZlf8Sn1ajIY4KewauLM49YeNl
 k3SrjVlVvEAbPaPkUPqeAT2p3uiMiDbW0CiQBXcRb70vl9lqIwJJjYT9NjoqhT8s35hikIgZC
 FlioOsA/R71YYdjlahA/LLKlmtmh8uol2ZPHE439MSXkCh3bYi8+wDaKEylcFl4Nj1yoDHLKf
 WQD+oo2kONCaqjeBxpK0KQsi3vbiKPPLAC4svV4RcFNggWJFS60gGbszTcGZO345ixgh6lvHA
 rjpTHRXPF9o8Db8qDxhnmoNkVEZNW9AVOa+WlepolrO4+CMMh09HRkv4+Zl5sdFDMzJ0//Amm
 7c6Lw8kuHk9EiDoSzRHsAJ+nXxVWjNW11xin1JOg0YTQO3jafd2rx2Z1yxvbhJE7Z9NYoeFz7
 UdFjlqZKeCO1+cWLdymhCyvxrAQLeE8VqaArFfxGEmXeVQAjm5Q9hsV7dNEvw5Gy8E1kVMkGY
 VyEPznF+ZYuPAQZpY1Hyk8EU9UVAYzsBRPUD6Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here are two more fixes for your LTO series. I still hope there
is a nicer way to get make LTO see the relocations from inline
asm, but my patch at least works.

For the modpost case, this is probably the right solution,
but I'm still testing it to make sure it's complete.

      Arnd

Arnd Bergmann (2):
  modpost: don't add warnings for LTO-generated symbols
  x86: make __ibp_barrier visible

 arch/x86/kernel/cpu/bugs.c | 2 +-
 scripts/mod/modpost.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.0
