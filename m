Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeDKJ3I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:29:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:48974 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbeDKJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:29:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="36318640"
Message-ID: <1523438944.2753.207.camel@gmail.com>
Subject: Re: [PATCH][v2] tools/power turbostat: if --max_loop, print for
 specific time of loops
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Yu Chen <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 11 Apr 2018 12:29:04 +0300
In-Reply-To: <20180410145141.31166-1-yu.c.chen@intel.com>
References: <20180410145141.31166-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 22:51 +0800, Yu Chen wrote:
> +		case 't':
> +			{
> +				int loops = strtod(optarg, NULL);
> +
> +				if (loops <= 0) {
> +					fprintf(outf, "loops %d should be positive number\n",
> +						iterations);
> +					exit(2);
> +				}
> +				iterations = loops;
> +			}

What is the point of the additional {} scope and the 'loops' variable
in it? You could use the 'iterations' variable directly and simplify
the code.

Artem.
