Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeDWOeE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:34:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36774 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754962AbeDWOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:34:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180423143357euoutp02958ae2ee684715b19546da9d2709b15f~oF0ATcJOI2202422024euoutp02c
X-AuditID: cbfec7f2-5ffe19c000011644-a0-5addeed240c5
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v7 0/6] Add coupled regulators mechanism
Date: Mon, 23 Apr 2018 16:33:36 +0200
Message-id: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7djP87qX3t2NMjg0Tc9i44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8aN
        rz+YCq7KV1w6vYu1gbFFsouRk0NCwERi5tTDjF2MXBxCAisYJbp+z2SFcD4zSixbcYsdpqrl
        x1omiMQyRonN3w5AVf1nlPj77BlQFQcHm4CWxJr2eJAGEQEbibc3DoCNZRboZ5aY3NTKApIQ
        FrCQWHl+GjOIzSKgKrHjXw8riM0r4CJx/M1rFohtchI3z3UygzRLCMxhk+ieOZURIuEiMWX5
        LmYIW1ji1fEtUOfJSFye3A3VXC1x8esuNgi7RqLx9gaoGmuJz5O2gPUyC/BJTNo2nRnkaAkB
        XomONiGIEg+J99umQ5U7Shy79QDMFhKIlXjb2sMygVFyASPDKkbx1NLi3PTUYsO81HK94sTc
        4tK8dL3k/NxNjMAIPv3v+KcdjF8vJR1iFOBgVOLh3aF7N0qINbGsuDL3EKMEB7OSCO/DN0Ah
        3pTEyqrUovz4otKc1OJDjNIcLErivHEadVFCAumJJanZqakFqUUwWSYOTqkGxubUPrcV3FWr
        tbYsS9x65tWla66vJOWzPC63Fqifusc9//B526qqLzrreh9e36ndGXM4oSVtVvYVpePrPbaL
        /etxuFbQUs7fz7urallu0e/vW1VYtkXF9p6yF8tt1A1Nnx6+5uinplO77HLvLOsRsr35WML1
        uO4acxvBmZ6fr6zYdHvbfNNOcyWW4oxEQy3mouJEADkg6lTcAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t/xy7oX392NMvjQpGSxccZ6VoupD5+w
        Wcw/co7V4uyyg2wWD6/6W3y70sFkcXnXHDaLBS9vsVisPXKX3WLp9YtMFq17j7Bb7L/i5cDj
        sWbeGkaPb18nsXjMbrjI4rFz1l12j02rOtk8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+PG
        1x9MBVflKy6d3sXawNgi2cXIySEhYCLR8mMtUxcjF4eQwBJGiV+vXrNDOI1MEp92/QdyODjY
        BLQk1rTHgzSICNhIvL1xgBGkhllgIrPEwsVXWEESwgIWEivPT2MGsVkEVCV2/OsBi/MKuEgc
        f/OaBWKbnMTNc53MExi5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgMp23Hfm7Zwdj1
        LvgQowAHoxIP7w7du1FCrIllxZW5hxglOJiVRHgfvgEK8aYkVlalFuXHF5XmpBYfYpTmYFES
        5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYGyfzTh5b1BF6nGzDbVfnF/r2PR3hSUtNalou7VS
        0u5hUPQZFvldZsVXli/cLmTGnmRUNvHEmuxpIYrL1WdN+vg69X3UT80wXmnmavVDJfyTxbSn
        zMrwrrgTq7fviumm27xHviemHQ+f5D5d9UBg8Oakoqagn5ZVq68HPbh3NseSu/GWiOKyk0os
        xRmJhlrMRcWJAJDpdNAjAgAA
X-CMS-MailID: 20180423143353eucas1p1d417b5995e380f6a7b168a98a76ecf40
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423143353eucas1p1d417b5995e380f6a7b168a98a76ecf40
X-RootMTR: 20180423143353eucas1p1d417b5995e380f6a7b168a98a76ecf40
References: <CGME20180423143353eucas1p1d417b5995e380f6a7b168a98a76ecf40@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patchset adds a new mechanism to the framework - regulators' coupling.

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires 
higher voltage, there might occur a situation that the spread between 
devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators. 

Algorithmicaly the problem was solved by: 
Inderpal Singh <inderpal.s@samsung.com>
Doug Anderson <dianders@chromium.org>

The discussion on that subject can be found here:
https://lkml.org/lkml/2014/4/29/28

Therefore this patchset is an attempt to apply the idea to regulators core
as concluded in the discussion by Mark Brown and Doug Anderson.

This feature is required to enable support for generic CPUfreq 
and devfreq drivers for the mentioned boards. 

The current assumption is that an uncoupled regulator is a special case
of a coupled one, so they should share a common voltage setting path.

The previous version caused locking problems on some boards. The discussion
can be found here:
https://lkml.org/lkml/2018/3/5/965

Current idea, which should solve the locking issues is making it possible to try
to lock a mutex multiple times by a single task just like it is done in clk/clk.c.
This should handle all possible coupling-supply combinations except coupling with
a supply.

The previous patchset should have fixed the locking issue
encountered by Fabio, but unfortunately it hasn't fixed Tony's problems with mmc.
I hope this patch fixes it, as the regulator enable path should remain the same.
I'd be very grateful for any feedback from Fabio Estevam or Tony Lindgren.

Best regards,

	Maciej Purski

---
Changes in v7:
- do not call regulator_balance_voltage(),
  when enabling a non-coupled regulator
- rebase against linux-next 20180423

Changes in v6:
- change locking model
- fix build errors on non-of architectures
- update bindings

Changes in v5:
- rebase against current Mark Brown's regulators next

Changes in v4:
- make paths for coupled and uncoupled regulators common
- coupling descriptors are now always present in regulator_dev
- fail to probe if data inconsistency is detected
- retry to resolve coupling regultors in late init call
- rebase on top of linux-next 20180119
- fix commit messages
- split patches to make the patchset easier to review

Changes in v3:
- move dts parsing code to of_regulator.c, in order to the so,
  add a new commit in which of_regulator_find_by_node() is moved
  to of_regulator.c as well
- improve error messages
- move max_spread variable to constraints
- perform resolving of coupled regulators under a list mutex
- remove useless locking functions
- some minor refactorization
- improve commit messages

Changes in RFC v2:
- allow coupling n regulators (in fact up to constant value, now
  set to 10)
- change algorithm to be more readable
- introduce better locking
- add more comments
- split first patch into two
- update commit messages
- change sequence of the patches

Maciej Purski (6):
  regulator: core: Make locks re-entrant
  regulator: bindings: Add properties for coupled regulators
  regulator: core: Parse coupled regulators properties
  regulator: core: Resolve coupled regulators
  regulator: core: Add voltage balancing mechanism
  regulator: core: Change voltage setting path

 .../devicetree/bindings/regulator/regulator.txt    |   5 +
 drivers/regulator/core.c                           | 553 ++++++++++++++++++---
 drivers/regulator/internal.h                       |  28 +-
 drivers/regulator/of_regulator.c                   | 151 ++++++
 include/linux/regulator/driver.h                   |  20 +
 include/linux/regulator/machine.h                  |   4 +
 6 files changed, 681 insertions(+), 80 deletions(-)

-- 
2.7.4
