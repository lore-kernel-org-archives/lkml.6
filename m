Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1223991-1521547443-2-13015956768640367236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521547442; b=Tr8ZO1nnIstQgXXT1jgdxXQT0g9SmpIDDpV9+0EkkifJ8Vj
    OGW9NN7eWp7OjkKAt1wGQMYBeXJK45WEKthDXfQNH4nuaR6dgTyRih8jHk5N0Y5S
    aWZbTw0dW/Hj9e58+UbIzWCrtZQDhKZA+avXRIcbDW4o+VgPha97BlV7BhRrZ9uF
    N+ULzMmkd1/GDq2AAVe7M9J5Y9hq75BvF5nWzj+G3//z/3ggfygmVEsnwICIOHzT
    wfJHYMh3hpQrdRlaUBC+7VoEG5rslgpJfM+5YGVq+wK4hBQNcmUESARX2M3for7t
    OzjmPa1AoK2xR0psUfxsvXstsGiZVZSyQpMPTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521547442; bh=9
    I7m0DGG3EoN+YAcm53nHeOp6UMx8NexJJsNcmxxMhM=; b=JjlzkFmSszAiiktvf
    SltAnJj+5jMZ3JuMTMn40zmC+cFttxUMZWWwx3/ArykYreQpiTMYzfNtkWRZL66h
    La5yC9EbJQ9Km1J+taemNRFP/jvsKIKiDWVjhss3yyLPUxoETFUuiNpa3q6amMIg
    ntwuV0rdRHjUs02b3QZoVNW/+qyzFc+WeeweNXWdJiPygUBHBTudQGqmpaMTRDwq
    UVgnDGNLL2AzqZIYOG+oqolHf6ARhHRSE45DyVeAshe7OTpCqLR7o420cigcS/qZ
    FU27BvI18XpFxQKq7UobLEyNzpmOX6Itf1gaJPXMr++7Y5a64dZVgu2I4RysJcgf
    Uiu4Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=TfaJKxU1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=TfaJKxU1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 20 Mar 2018 15:03:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Pratik Jain <pratik.jain0509@gmail.com>
Subject: Re: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Message-ID: <20180320120344.fyhw4iry4xrtxjpu@mwanda>
References: <20180320083549.6795-1-pratik.jain0509@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180320083549.6795-1-pratik.jain0509@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837
 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, arnaud.patard@rtp-net.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 02:05:49PM +0530, Pratik Jain wrote:
> Refactored the function `XGIfb_search_refresh_rate` by removing a level
> of `if...else` block nesting. Removed unnecessary parantheses.
> 
> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> ---
>  drivers/staging/xgifb/XGI_main_26.c | 63 +++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
> index 10107de0119a..ef9a726cd35d 100644
> --- a/drivers/staging/xgifb/XGI_main_26.c
> +++ b/drivers/staging/xgifb/XGI_main_26.c
> @@ -544,41 +544,44 @@ static u8 XGIfb_search_refresh_rate(struct xgifb_video_info *xgifb_info,
>  	yres = XGIbios_mode[xgifb_info->mode_idx].yres;
>  
>  	xgifb_info->rate_idx = 0;
> -	while ((XGIfb_vrate[i].idx != 0) && (XGIfb_vrate[i].xres <= xres)) {
> -		if ((XGIfb_vrate[i].xres == xres) &&
> -		    (XGIfb_vrate[i].yres == yres)) {
> -			if (XGIfb_vrate[i].refresh == rate) {
> +	

There is a stray tab here.  You didn't run checkpatch.pl.

> +	// Skip values with less xres

Linus likes this comment style, but I would prefer normal comments,
please.

> +	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres < xres)
> +		++i;
> +

I have reviewed the code, and I still find the single loop more
readable.

> +	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres <= xres) {
> +		if (XGIfb_vrate[i].yres != yres) {
> +			++i;
> +			continue;
> +		}

I would like a change that did:

		if ((XGIfb_vrate[i].xres != xres) ||
		    (XGIfb_vrate[i].yres != yres)) {
			i++;
			continue;
		}

so we could pull everything in one tab.

> +		if (XGIfb_vrate[i].refresh == rate) {
> +			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
> +			break;
> +		} else if (XGIfb_vrate[i].refresh > rate) {
> +			if (XGIfb_vrate[i].refresh - rate <= 3) {
> +				pr_debug("Adjusting rate from %d up to %d\n",
> +					rate, XGIfb_vrate[i].refresh);
>  				xgifb_info->rate_idx = XGIfb_vrate[i].idx;
> -				break;
> -			} else if (XGIfb_vrate[i].refresh > rate) {
> -				if ((XGIfb_vrate[i].refresh - rate) <= 3) {
> -					pr_debug("Adjusting rate from %d up to %d\n",
> -						 rate, XGIfb_vrate[i].refresh);
> -					xgifb_info->rate_idx =
> -						XGIfb_vrate[i].idx;
> -					xgifb_info->refresh_rate =
> -						XGIfb_vrate[i].refresh;
> -				} else if (((rate - XGIfb_vrate[i - 1].refresh)
> -						<= 2) && (XGIfb_vrate[i].idx
> -						!= 1)) {
> -					pr_debug("Adjusting rate from %d down to %d\n",
> -						 rate,
> -						 XGIfb_vrate[i - 1].refresh);
> -					xgifb_info->rate_idx =
> -						XGIfb_vrate[i - 1].idx;
> -					xgifb_info->refresh_rate =
> -						XGIfb_vrate[i - 1].refresh;
> -				}
> -				break;
> -			} else if ((rate - XGIfb_vrate[i].refresh) <= 2) {
> +				xgifb_info->refresh_rate =
> +					XGIfb_vrate[i].refresh;
> +			} else if ((rate - XGIfb_vrate[i - 1].refresh <= 2)
> +					&& (XGIfb_vrate[i].idx != 1)) {
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This bug is there in the original code, and not something that you
introduced but the second part of the if condition is to ensure that
we didn't do an array underflow in the first part of the if statement.

These days that can trigger a kasan warning, I believe.

The conditions should be swapped around to avoid the read before the
start of the array altogether.  And, in fact, it should be written like
this to make it easier for static analysis tools:

			} else if (i != 0 &&
				   rate - XGIfb_vrate[i - 1].refresh <= 2) {

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
