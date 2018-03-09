Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeCIMWj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:22:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46435 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCIMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:22:36 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180309122233euoutp0150c8d91ae38a26221a72ebad9eb258e9~aP-bcSWU41639716397euoutp01_
X-AuditID: cbfec7f2-1c1ff70000011644-b0-5aa27c8842f2
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v6 0/5] Add coupled regulators mechanism
Date: Fri, 09 Mar 2018 13:22:02 +0100
Message-id: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfUgTcRjH++1edg4Xxyn58yWhVRRWphB2oIwM/ziMqKAIF2WXHs5yU++c
        qVlYsZwzTKalmPgGioz52pqmSDZkkuJgOrEsSynEXgWXw7Qy5+l/n4fv53mBh0CoYTSESNfm
        cLyWzVDgMtTm+O08YihsUkX1TwXTXdUdGP147jNO1w85MXqs5RVOz02eob1ug4Se6KvF6YYv
        0yjdNjQjpZunXBJaPzAkpV+6E0/4M5Y6C2C8yyaUeVrkQpkXNTNSpttcgjNlVjNgPN3hZ6Uq
        WVwql5Gey/FHlVdl6l+dCVn3d+c91DulReD7LiPwIyB5DK7VORAjkBEU2QrggsGGiYUHwErr
        HLZtrVS8xsWgBcBGr14qFusA/unskBgBQeBkBLQUJ/saAsk4+OPNIPA5CPkIgRX39KgvCCBp
        WDZq2mSU3A9dH2skPpaTCXBlrAcXt4XDt86SzZsgWYvDpQ8jiG8B3JAMi7zoBMCvw1apyGFw
        oqIUFfkWdC33bc0phHffdW45sdBjsiI+Rsid0GSr2hoph4YHlKgwcNrdJhE5Hk56qoGPKfIy
        bK5bR8pBcAPYYQZBnE7QpHFCtJa7GSmwGkGnTYtMydR0g433jv4bXuoFy+PX7IAkgMJfPhvf
        qKIwNlfI19gBJBBFoLwgr0lFyVPZ/AKOz0zmdRmcYAehBKoIkl85eEdFkWlsDneD47I4fjuV
        EH4hRcCMrmtWsdOH55Vkz/uFzqpD7sCx+sTFqkFVZWs2EtHKNz3v3xv70328PesbW5B923q9
        zDVbryt2ha51ZYfsC1eqz59jPUmp3vgDttKBUzMOZX9SykghFgPCVi+dvHihfKrB9Lfkyeon
        tcNOUr3ui/MqzDLenmyMqYkq3vOsWYEKajY6AuEF9j8cy8F82gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e/4Zd32mkVRBtfnGVtsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFw6v+Ft+udDBZXN41h81iwctbLBZrj9xlt1h6/SKTReveI+wW+694OfB4
        rJm3htHj29dJLB6zGy6yeOycdZfdY9OqTjaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyviy
        waWgWbaip/UcewPjG7EuRk4OCQETiR+TT7J1MXJxCAksYZT49A7GaWSSWH31DUsXIwcHm4CW
        xJr2eJAGEQEbibc3DjCC1DALTGSWWLj4CitIQljAQqLv9CQWEJtFQFXi4v1ZTCA2r4CLxI+z
        29kgtslJ3DzXyTyBkWsBI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwGDaduznlh2MXe+C
        DzEKcDAq8fA+cFwYJcSaWFZcmXuIUYKDWUmEt6piUZQQb0piZVVqUX58UWlOavEhRmkOFiVx
        3vMGlVFCAumJJanZqakFqUUwWSYOTqkGRt+HZ4++E5XcyNF6akJi9d+T91R97guw3Zr/ZPpF
        0dUzmFlFvu7p2iWjHxxncFmvxNxrf3rzlAvFH1sdmd/l21l71WxUVTSJi2GT2SPaIfTgqYIs
        Wxb/jVqDI0t2pKV6mCvwLjzs2sXSrGUrIi+4r7+wbe7uu3k10WdUW1/Xsv0tzle9Z35XiaU4
        I9FQi7moOBEAwYRTFSICAAA=
X-CMS-MailID: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
X-RootMTR: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
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

I would like to kindly ask Fabio Estevam and Tony Lindgren to test the patch
series on their boards.

Best regards,

	Maciej Purski

---
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
 drivers/regulator/core.c                           | 549 ++++++++++++++++++---
 drivers/regulator/internal.h                       |  28 +-
 drivers/regulator/of_regulator.c                   | 151 ++++++
 include/linux/regulator/driver.h                   |  20 +
 include/linux/regulator/machine.h                  |   4 +
 6 files changed, 677 insertions(+), 80 deletions(-)

-- 
2.7.4
