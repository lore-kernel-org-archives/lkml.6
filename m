Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeCMJbj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:31:39 -0400
Received: from mout.web.de ([212.227.17.11]:47259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751975AbeCMJbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:31:38 -0400
Subject: Re: hwmon/sch5627: Use common error handling code in sch5627_probe()
To: Hans de Goede <hdegoede@redhat.com>, linux-hwmon@vger.kernel.org
Cc: =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <d08248a2-46d8-6f73-81f4-84ad21b7e640@users.sourceforge.net>
 <0cc0ab31-550b-fa34-aaa5-164f6ae7f7a9@redhat.com>
 <17810b74-7b72-074e-5fef-b614fcfed738@users.sourceforge.net>
 <e8a45f50-b625-ccb5-88cc-b888f57d1ca1@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4e0856d8-3b2c-35f0-50a5-bfbe34615dfa@users.sourceforge.net>
Date: Tue, 13 Mar 2018 10:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e8a45f50-b625-ccb5-88cc-b888f57d1ca1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:10LFJeklu7eHWUOxzPlZC/fg7ZNBzBaknHOisVxR+7W1Syqyrto
 OQY+ZDPENm0+cXSyU4HsTS+p8D+t6srf30gbOGD6UuE827nYXNTAYZGdeYeSg7Hen+KGzqL
 FVfgXZ2QQ8UGTzugTHZcmRtcFFhSFCMUSgy3wOgny+erEjpJsUCG/kyw82b3E1kZXSE+Ae7
 Sn0uYw63SOtS0HI1c6R7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uJLC7GIYscU=:JObwwJ1C2BkrX7884mtf8J
 0QbbI/NHlSuQ+ikqPxtUOFJtsXWTSO8gpPkccBPDJsVQm8WNR10wjq4QZQKz/4kOxwJYPNkof
 jxSfYvh/CxT8vuCt1+JDiJDrjpsDm8AvY3JBToJcrtBsa7Ueiv7ODtolnDDt8tIUo/fcaZu7q
 CIFcVGq1UfsBdwCX3xzy9nfoExAvS1UGm/UYXPRfcJMlU55t/DJdEScpvzhV5eMzjmDzXVDB1
 Z6Hl85KNbQF6E7SWbE5UZDOTQ0mYqIQa24wZbB6xQTB4Lyb+gRiqlSEPEDzdQJD3yDbk01CM7
 A8/Ru0+vVPaR/vFZGzYcm+dgjacYKDsZcpMCUVsnmkVwilgZdf1/PZ+eRnozUiHVv224Xoy93
 RfR7I3ls3Rm1/JyBrctZfXzMaLCwhVAKoRVtLA3mrR6z5lu8rTPgjoV9dNiR97/9Ou7F1Jez5
 fj5lYk/whwQcQqdf/fdRWuYi1F2YRS9hK59QWEZQ4nLAHCG4gosyQjoTrZWg5btLHOdQ/KJIZ
 V/c5p0WiCId18qd/+VWqbuQrsaiz3gdyI9nKO4gdO9suTi/DSB5JzVh0lGMw9UnnOFLvQEpw2
 FXkj+CT1IBNn1zkThdqf/Bf9Sv7dsGmBJY01dmh3VrS9zL6Os0VrMkGoq5pxaRyAo1u7ZFu2C
 SFBF9n+CJJ8tbAKxaEF32tWqRbA0PYROlamA5BZLrN4srf9nRPckChbKqd9LPzwaJyiLXzs8n
 SPjw1iy+U2ze5fzBrRQ0fgdiggPb5eyUCY8foeRZlQa4f3yPPsJLduirY0m3Wertf5o1cAoyy
 5FTJnUDLFLlpBYfLdvdcddWZwKvo57pCVj3kK4fsUS2e9WDy2M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  1 file changed, 29 insertions(+), 31 deletions(-)
> 
> So you are asking people to review 60 changed lines to save 2,

A bit of object code reduction might become useful also in this case.


> that alone should be the point where you stop yourself from
> *even* sending this patch.

I proposed just another collateral evolution.


> Next time before you send a patch please carefully think if the
> saving is worth the combination of reviewers time + the risk of
> regressions (and keep in mind that both the reviewers time and
> the risk of regressions cost increase for more complex changes).

Source code transformations were integrated in other software areas
according to such a change pattern.


> As for this specific discussion, there are certain "design-patterns"
> in the kernel, goto style error handling is one of them, the pattern
> there ALWAYS is:
…
> Notice the fall-thoughs those are ALWAYS there, never, ever is
> there a goto after a cleanup label.

It seems that I present an unusual update suggestion as a software
design variant.


> Your patches black goto magic completely messes this up

You can view the proposal in such a way.


> and clearly falls under the CS101 rule: never use goto.

There might a target conflict with information from the section
“7) Centralized exiting of functions” in the document “coding-style.rst”.

Regards,
Markus
