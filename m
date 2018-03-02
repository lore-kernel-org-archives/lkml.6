Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165052AbeCBIva (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:51:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60983 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164949AbeCBIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:23 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180302085120euoutp010ea9f096e5dbf462a1d261213d918393~YDmAt4AF32751027510euoutp01V
X-AuditID: cbfec7f4-713ff700000043e4-8e-5a9910875345
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v5 0/5] Add coupled regulators mechanism
Date: Fri, 02 Mar 2018 09:42:44 +0100
Message-id: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7djP87rtAjOjDPYcZ7PYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLb1c6mCwu75rDZrHg5S0Wi7VH7rJbLL1+kcmide8RdgcujzXz1jB6zG64
        yOKxc9Zddo9NqzrZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj/7Ln7AXPJSte9nxjbmCc
        K9LFyMkhIWAi8eHCc3YQW0hgBaPE5eOyEPZnRomzO2Jgah6/b2HqYuQCii9jlJhwtY0dwvnP
        KHHs+EK2LkYODjYBLYk17fEgDSICNhJvbxxgBKlhFjjOJHF96kYmkISwgIXEry1bWUBsFgFV
        iX+nN4Nt5hVwlng7pYMFYpucxM1zncwQdg+bxNk1fhC2i8TOtgZGCFtY4tXxLewQtoxEZ8dB
        Jgi7WuLi111sEHaNROPtDVA11hKfJ20Bm8kswCcxadt0ZpCbJQR4JTrahCBKPCQ+XTsE1eoo
        sWfdWTZIQMRKfN6/lnkCo+QCRoZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgRF6+t/x
        LzsYd/1JOsQowMGoxMOb8X5GlBBrYllxZe4hRgkOZiUR3pYPQCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbGoA93u2sfXtZZc217Q9reljpH4brUaS0a
        THO3rL1oUxqn0XRp/duanZcNFugI6Pj/eaVb/atge8NvlpCbj6xbxU0PN/QnXnXNL/9zZVrB
        09cNvaV7jr+UfLwzevoxHellLyQVpmv/5fFe6HP1XFNCUdNj9zv3XleL25lpP1C3leyyqVh0
        gW2vEktxRqKhFnNRcSIAmItstswCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e/4Zd02gZlRBv3tChYbZ6xntZj68Amb
        xfwj51gtzi47yGbx7UoHk8XlXXPYLBa8vMVisfbIXXaLpdcvMlm07j3C7sDlsWbeGkaP2Q0X
        WTx2zrrL7rFpVSebR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGX8X/acveC5ZMXLnm/MDYxz
        RboYOTkkBEwkHr9vYepi5OIQEljCKDGjfSkzhNPIJHHgynLGLkYODjYBLYk17fEgDSICNhJv
        bxxgBKlhFjjJJPHn4jpGkISwgIXEry1bWUBsFgFViX+nN7OD2LwCzhJvp3SwQGyTk7h5rpN5
        AiPXAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFBs+3Yz807GC9tDD7EKMDBqMTDe+Dj
        jCgh1sSy4srcQ4wSHMxKIrwtH4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRm
        p6YWpBbBZJk4OKUaGJsTbk/4lx69VveSlP60Ze0ioft/+JTl6NR2p+u3/rcKOLymePqzE0kF
        81kMuc6KPLQQ9vFyO+8YK++eeFSuu5DxskFs5CeGQMGqrpnT7gb51bVPu328XeTogaIyibVm
        grvSExu3Od9/6fdukUj6qoyv3X9dpLpctBNWzEm4vOfs4ZSiTz6FSizFGYmGWsxFxYkACY+e
        PRYCAAA=
X-CMS-MailID: 20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120
X-RootMTR: 20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120
References: <CGME20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120@eucas1p1.samsung.com>
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

Note on the locking model:
When balancing voltage of a group of coupled regulators, we lock all
of them for the whole operation. When voltage of an individual regulator
is about to change, its suppliers are additionally locked.

The current assumption is that an uncoupled regulator is a special case
of a coupled one, so they should share a common voltage setting path.


Best regards,

	Maciej Purski

---
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

Maciej Purski (5):
  regulator: bindings: Add properties for coupled regulators
  regulator: core: Parse coupled regulators properties
  regulator: core: Resolve coupled regulators
  regulator: core: Add voltage balancing mechanism
  regulator: core: Change voltage setting path

 .../devicetree/bindings/regulator/regulator.txt    |   5 +
 drivers/regulator/core.c                           | 381 ++++++++++++++++++++-
 drivers/regulator/internal.h                       |   6 +
 drivers/regulator/of_regulator.c                   | 149 ++++++++
 include/linux/regulator/driver.h                   |  18 +
 include/linux/regulator/machine.h                  |   4 +
 6 files changed, 545 insertions(+), 18 deletions(-)

-- 
2.7.4
