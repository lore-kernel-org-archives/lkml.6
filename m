Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeDJLC2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:02:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:1084 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDJLC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:02:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="35974932"
From: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Thread-Topic: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Thread-Index: AQHT0LTjq94pXP8omE6pWKqBov9U26P5xJ6A
Date: Tue, 10 Apr 2018 11:02:22 +0000
Message-ID: <1523358141.2753.194.camel@intel.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
In-Reply-To: <20180410101831.28530-1-yu.c.chen@intel.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.68.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CAD6EC5472D3B4BA0D098C7505E52A5@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3AB2XJS019571

On Tue, 2018-04-10 at 18:18 +0800, Yu Chen wrote:
> @@ -5076,6 +5084,15 @@ void cmdline(int argc, char **argv)
>                         print_version();
>                         exit(0);
>                         break;
> +               case 'x':
> +                       {
> +                               unsigned int loops = strtod(optarg, NULL);

It would make sense to error out here if you get a value <= 0.

> +
> +                               if (loops % 2)
> +                                       loops++;

What is this for?

> +                               max_loops = loops;

Is the "loops" variable really needed? Can you strtod directly to
max_loops?

-- 
Best Regards,
Artem Bityutskiy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
