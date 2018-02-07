Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeBGMiz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:38:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:60195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753763AbeBGMiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:38:54 -0500
To: linux-kernel@vger.kernel.org
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Subject: adding plan9-like usernames to the kernel
Cc: aganti@google.com
Message-ID: <0597ffe1-f80e-d5dd-e20d-da68bd8a189a@gmx.de>
Date: Wed, 7 Feb 2018 13:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DhWrWpr/WuoVHaIN9y7AfCn+QbYCqVJ8fi/TIZHaOysff8NuXV7
 qQkTl/9BUxrDHuWy4o8MpjbE8gxiwVeABA5GllSBeP+Tol4VMDhslFm+EKP57YxwdjslXpB
 WMICYscJFgqhDnZKwcf1qSeqSYVFObTEzCqzPuGV37oi3YL8QOC2XbLOUweY0Dt62siwewm
 vQEr9+dJpGMPPnIAJ4xNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KF3/urBnHiY=:DnKbjzwuOebDbM98JHNJVL
 hXoKIL7tEWYGYIf9qvT5Oh1W/8NnHweeumwbfS6jAY8ZX68LF2m3ljJzapyuphiziaEGjFDii
 19Xf7O/xlNkx+O8XT8lnvmlF8eKEI3klPTmGQakI3R+h0c/Ecdfr7jci4YpIQImx0yUrO3pBW
 6lGma5hyDwgxhx4I8Jcn8OmgneTz7JFABYPy283FxMrkaUv+wQCsQt2JeVUG438bnjcvqDyHp
 ppuzEqiCn+u7VHppGzl488TNU+PXEtX0YRGwdczvDggaBDldzFVslusBhKj05bpbHSw3vJEna
 z6+Ts8a5wG1z1rVC8pdlu8BbFf7Po9nAPjoLt7kHp1Fr6057wu/PPlvqlEBfV+iMnDjCl+s3U
 qH0Eo0xntiCy7YW0TmYixPBlQwYh7KQuy+il+f3oUJ+YszuJc0gLtTdFErFYLWuTnK35X3+L5
 E6myVeBBULHfhoOpSJF648nRg+iIDWuXVcYibZYl66Z2Y7CWmR1idapL1VPBxFGsyXqgak1pH
 pe22woQ4pYm6UCLno7EuvRuZm91PIKWgWwTPiz5AhP5oZjBslS8AzVRCi4zlifDJcbvpYVH1r
 2BB1tlXuPD3ISM6aUDXK76ivdZpkvPnXvZHADp9DsJgzu152GOn5lgQggwoWWGVz/bf/dR58o
 WHH7IKv2JBpbyb248wooEMZsrbqO0vSbQPahlAypEKVZMJC4duXfWge3W0IRdys4FDOkL+Ie7
 hthb46bWryON0AoS0WDdRPUNPyWf/46U0nT+AP+KOTSWZbTHpmIKvU8LYqUIlDsEHVcwaO2iz
 1OlImW4KAU+uBRLhYcOi7OY6I+W9naEjcbeK/gAmTm6KvR9KsM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


as part as a little research project for bringing Plan9 semantics
to Linux, I'd like to add textual usernames. In contrast to *nix,
Plan9 doesn't use numerical IDs, but names.

Obviously that needs some internal mapping between names and ids.

Should this go into struct user_namespace (where per-namespace
uid mapping lives) or to struct cred / struct user_struct ?

The primary consumer of this username will be the /dev/caphash
and /dev/capuse devices for switching the UID.
(an interesting question of course is, how to allocate the
numerical UIDs for given usernames)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
