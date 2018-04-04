Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDDKfz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:35:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60510 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeDDKfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:35:53 -0400
Date: Wed, 4 Apr 2018 13:24:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Colin King <colin.king@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Message-ID: <20180404102425.cwj7vzvrvi2obcoi@mwanda>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403134540.GA29017@lenoch>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=373
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:45:40PM +0200, Ladislav Michl wrote:
> On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> 
> Hello Colin,
> 
> > Trivial fix to spelling mistake in pr_debug message text
> 
> would you mind making this patch a bit less non-trivial and
> change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> 
> Thank you.
>

Trivial patches should just be trivial instead of evolving into a thread
that lasts for days.

I sometimes write trivial clean up patches for things like:

arch/x86/lib/csum-partial_64.c:97 do_csum() warn: inconsistent indenting
    88                          /* last up to 7 8byte blocks */
    89                          count %= 8; 
    90                          while (count) { 
    91                                  asm("addq %1,%0\n\t"
    92                                      "adcq %2,%0\n" 
    93                                              : "=r" (result)
    94                                      : "m" (*(unsigned long *)buff), 
    95                                      "r" (zero),  "0" (result));
    96                                  --count; 
    97                                          buff += 8;
    98                          }

Why is "buff += 8;" indented too far?  And why does every line end in a
space character?  And I think about it for 10 minutes and then delete my
patch because it's too much hassle to deal with for something small.

regards,
dan carpenter
