Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeFEJBL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:01:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38740 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeFEJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:01:10 -0400
Date: Tue, 5 Jun 2018 12:00:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Janani Sankara Babu <jananis37@gmail.com>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH] Staging:greybus Fix comparison to NULL
Message-ID: <20180605090051.fngwzwpzr37ynatf@mwanda>
References: <1528030371-3822-1-git-send-email-jananis37@gmail.com>
 <20180605053236.u57riboa47so66rr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605053236.u57riboa47so66rr@vireshk-i7>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806050109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:02:36AM +0530, Viresh Kumar wrote:
> On 03-06-18, 08:52, Janani Sankara Babu wrote:
> > This patch replaces comparison of var to NULL with !var
> > 
> > Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
> > ---
> >  drivers/staging/greybus/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/core.c b/drivers/staging/greybus/core.c
> > index dafa430..5d14a4e 100644
> > --- a/drivers/staging/greybus/core.c
> > +++ b/drivers/staging/greybus/core.c
> > @@ -48,7 +48,7 @@ static bool greybus_match_one_id(struct gb_bundle *bundle,
> >  static const struct greybus_bundle_id *
> >  greybus_match_id(struct gb_bundle *bundle, const struct greybus_bundle_id *id)
> >  {
> > -	if (id == NULL)
> > +	if (!id)
> 
> It is pretty much personal preference and there is no good reason to accept this
> patch really.

Checkpatch complains, so it's Official Kernel Style now.

The != NULL comparison is a double negative which makes it not less
annoying than official kernel style.

regards,
dan carpenter
