Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEJV7j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:59:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:50459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752412AbeEJV7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:59:38 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] powerpc: Wii IRQ fixes
Date: Thu, 10 May 2018 23:59:17 +0200
Message-Id: <20180510215919.27808-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dRiFqmLgf3swnkeAnWFlQYoNI1G0mUn52wkloMN8gpKXREjhZRN
 K08QVA39a8BbWG5aRqLGh+zln9+UqzF++2S8O5oE3olPUaaNZRnr9ygZVGZRUM9UESkeonF
 rHfJyzb+o028UlojaIbNeojx+I0WR+6C970y1AEZAQsz43fy1aSee9SxPrdzEBWnxMiOvPn
 3cbWp9ZvfcLM06zo4ydjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dKNrvObtTYo=:WUOhc33xwtv+49bCfE0fUa
 A+QPojeqXmRjQAPqXqgkUl4d+3U+5/GRnFFfPrb+UWOaBF7/U8zVfJlttQuu0m6fjfBcKifBn
 oucC3KP2HSuMUZhKagSr0M7VNDegQumPklHcKEHxPbhw1RKdEWOYwoiewnX6jo7xXeO3f0qC7
 cCOcySnE4nATW39MYeC+fAkjqGVnO9eaKW4ec/r5Jg1mtOCQHeuCw9Fjjf8jFHJLoy3iUM1PA
 jjyphOXY9tsXFOzI4jaALkKINv5YsfimdWKEbBiORvtXi935lVtKAB1roFzfk9YFrOrEYEY6v
 9cJlprKn8qBrPVeU7Uvqa5FYx4ws1HgOtHJhCiyoZ7VEnEzhF+OQO5sZhXx4CvXHLjPX3lezy
 Wy3xbQLHOsk02Itlu6rmIYeG66m14FDEyZ1vkHhsMdFbKKzZ/EbncPHZ2ma9xFxpW9IZIJ8fP
 kbYKyHCxXYXMadkph3WrCSKVk0poZ7RekdruIXxK0m7OwcgX9kd6HVxHHJSIIepcatW/Dpa4D
 KR0tQmTIUruSSCyvHWp1BYLK2zJraNJM7F2uVXHIWv/Zw0fOIf/PkGMqWZFWkGSrtMA+BwvVb
 xJk4rV5UdJuIszN1Jb3kY1XoDcdO9bdAJjuyMoqxrAjJvBnQIby0aqPHRt/h5kYzflOkReQsx
 nGVd1vfZ18eIqNPQhjX3LD7dmSqTu0a7VkmkoDAMqdzMWyRyqYxnQq78Q8RwrINbieSLtRjO5
 oMA835R3vaUpASWoyJdymkMEpauZwD/24XL8hCDfFSjCcsBl8bsiJ8awkPtgoVmaq02U/Tuf9
 iwFeXDI
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes it possible to use the SD card on the Wii. The WLAN
now also works on the SDIO level, but fails to connect to a network for
some reason.

Patch 1 seems quite obvious, although I don't know why the code was
broken in this particular way.

Patch 2 might not be the right solution for the problem at hand, but it
works and should only cause problems when both processors in the system
(PPC and ARM) try to use the same interrupt, if at all.

Jonathan Neuschäfer (2):
  powerpc: flipper-pic: Don't match all IRQ domains
  powerpc: hlwd-pic: Prevent interrupts from being handled by Starlet

 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 8 --------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 5 +++++
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.17.0
