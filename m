Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeECMaj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:30:39 -0400
Received: from mout.perfora.net ([74.208.4.197]:47811 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbeECMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:30:34 -0400
Message-ID: <1525350612.5836.6.camel@ziswiler.com>
Subject: Re: [PATCH v1 1/4] clk: tegra20: Add DEV1/DEV2 OSC dividers
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 May 2018 14:30:12 +0200
In-Reply-To: <440e71db-cd0b-c4d8-eb24-ac8ebec9ae75@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com>
         <20180426235818.10018-2-digetx@gmail.com>
         <1524832404.6979.9.camel@ziswiler.com>
         <a8fc30b9-42ce-b29a-abc6-2867ebf4a9ac@gmail.com>
         <1524834018.6979.13.camel@ziswiler.com>
         <7c4e96ea-8bcf-1643-1b0f-29dc85b62b7b@gmail.com>
         <440e71db-cd0b-c4d8-eb24-ac8ebec9ae75@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UCaXvmFuAuBy8TUq/HgtPgPcnerZu38YOOTwE5INVhNqeOkgacl
 Opgndmt1NtgM4IpVRAXy1jftx9SPscKTu4iHMtQpjPjH76DEbPWqO4t7UM9lfCZvju8JUgc
 mpEq/cMWChHvjH9jd9BYNd2o21L1eTjrYzLjLWRoVNNp1QWzVDftUzG3dBx0lTrW0FBT3N9
 3H3lhKV8YdqZ0oYVNtocQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8ytznv0eQxs=:DEWXrFFgdPmcCA2iJm6IQF
 UxUNkpAHSPkHkNG/7l9v49tYFVyYLmwbmHYO7kRM6ZwT4N4mpcDQJvY2XiHqZs6WZjB1aNflq
 tlTzFXrsFA+uTBnvyYQAnP7fTeeyLNDvvmi4bLGVsXMUB6ZfUx0GvMtujmzLuvrXwT7vJ/9BB
 X4yIeQABuITjxcX1VdyRVPu+4SexcJQiOiR35KPQhHBeZzF52OJrqM3aUrkWB8Q9m6flJlICc
 K7Xd2a5FeLqYkMYadzVdkH1Vpg0AuiAwd4ZCinUV3QiRbXLijFc0FR53nGQXLOz6sdad/7y97
 ZvxQ6Wf//dEuKhj6J+Flr0ENSc27iQXoxzLzSJahIk6HhncGR92Y2LhBpqguesuQQ0yor+qcl
 9VV39Bjm77q6+ZnWhTvAy3Zlo+hmn/8fBmsMY1zoO+Y2Z9ahepytT05XZqwz5yYWOQ43pPwHb
 +zL11LDm1xquulf5Z6xrSUJI5b9RThp1uJZFDqGX6CAjJz/B4N/neHN/kpZHgvOlnwV9B6xiG
 EWitYlthNgurNkYW5LkbnNoLEZ/HJrbphI7SqPJCgQBmvZNPBc6+1Vbm3tpyawelMj0dQ+WQZ
 GO+UpnlSlPm6WDQwvm1gHscawoAQXBraX2D5/CwQ9YLUT1FkOH+991yIl33cjjncOm0EhTypD
 vHI2IjhxA9auRAsFwTGogyQufGU2/olicbt42E1iALXpbjhDsEjMJ8NbA7QNCIKoIraeJL7RD
 YXUBot9zPGFX0JYZ
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 15:02 +0300, Dmitry Osipenko wrote:
> ...
> > Marcel, you previously mentioned that reverting of your DT patch
> > works for the
> > Colibri now. Does that reverting also work for the 4.17 kernel? If
> > yes, I may
> > add stable tag to the revert-patch to get back paz00 working with
> > 4.17. If it's
> > not working, we should figure out why pll_p_out4 is getting
> > disabled as it
> > should be a distinct issue.
> 
> Oh, I just found that Thierry already asked to get this patches
> included into
> 4.17. Anyway would be nice to know if a sole DT revert works with
> 4.17 for you.

Yes, 4.17.0-rc3 with just 4c9a27a6c66d4427f3cba4019d4ba738fe99fa87
reverted works fine as well.
