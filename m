Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeCOKZR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:25:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:17455 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeCOKZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:25:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="38196789"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Gary R Hook <gary.hook@amd.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH] Documentation/CodingStyle: Add an example for braces
In-Reply-To: <152106609844.18780.6843553697430932588.stgit@taos>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <152106609844.18780.6843553697430932588.stgit@taos>
Date: Thu, 15 Mar 2018 12:26:09 +0200
Message-ID: <87zi39ljni.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Gary R Hook <gary.hook@amd.com> wrote:
> Add another example of required braces when using a compound statement in
> a loop.
>
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  Documentation/process/coding-style.rst |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index a20b44a40ec4..d98deb62c400 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -200,6 +200,15 @@ statement; in the latter case use braces in both branches:
>  		otherwise();
>  	}
>  
> +Also, use braces when a loop contains more than a single simple statement:

Personally, I'd not limit this to loops.

	if (condition) {
        	if (another_condition)
                	action();
        }

You could argue the existing rule already covers these cases by
excluding selection and iteration statements from the "single statement"
in "Do not unnecessarily use braces where a single statement will do."

BR,
Jani.

> +
> +.. code-block:: c
> +
> +	while (condition) {
> +		if (test)
> +			do_something();
> +	}
> +
>  3.1) Spaces
>  ***********
>  
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jani Nikula, Intel Open Source Technology Center
