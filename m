Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3621199-1521624324-2-1286366412377789185
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
    t=1521624324; b=JSsrFUWpO6+sPkTv3lAq18idu6Lo+wRY0H2BDpi7EiWT71O
    /gyhV59RQPeonFcvtqUj3Qcss2uhJZ7bt3XHEugW1PN08qddkdK+n7MgkUkzE8w1
    vvAECoXA/zA65bGK9EeMDnfs+srEG2AmBceM+RV6h5OG3C2XA4lkZZ1rTpZas7o4
    MEzvuizA7EuY7FUwFZAycK+v5CrupGbTQFa01KtPPaqANmKc5j5talt4o2h9/Irj
    slsBbrYdCMwQt2BWdcYF5IJRObKBYMRiHwt1r+Iwt7msf//5SfP3YDlFW3G0Yju/
    TmVb+MwcQ3fgHKwEARU07Za8Z3k2S2vPeqX/ZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521624324; bh=t
    kKeqjYwyfzlQR/O+1E353Pu45H3SnKx/43Lv+ynhKo=; b=O/CZK4wj+EsU2Sd+l
    HK9iZa2ZEIeghBOCmoySHD7qD20vdwRrN8f/YdqZ814GqfwPPPZqkXNSWVt2BPz5
    tR9N5YwOlJQ3veeqarTk7enkaArgc5RYAtVsxV4AiU6XAlOSl4ZO/w9iiY1gSiMc
    sCgkhR5nwkdkJITlyrTl5/PfE39EtgQHodtFGQwAexZ/CSwYv3xaYw4RLUfCB3YM
    5s3YgTEfd1ITGQyLvQ/uSxWJC2OuUpxkzBgB4qCkWKeugfNXCrU4hzad0/uZlNAK
    XKdabkv4oNC3s2P0ETooAlZwNBSw4SeNwfjC8J9AnbKG5bbunhp6i5CQAPYpXtqu
    n5V/g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=YSYAQaf0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=YSYAQaf0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
Date: Wed, 21 Mar 2018 12:24:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Pratik Jain <pratik.jain0509@gmail.com>
Subject: Re: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Message-ID: <20180321092458.76v5jujepp2inmov@mwanda>
References: <20180320120344.fyhw4iry4xrtxjpu@mwanda>
 <20180320140232.26096-1-pratik.jain0509@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180320140232.26096-1-pratik.jain0509@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838
 signatures=668695
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

On Tue, Mar 20, 2018 at 07:32:32PM +0530, Pratik Jain wrote:
> Refactored the function `XGIfb_search_refresh_rate` by removing a level
> of `if...else` block nesting. Removed unnecessary parantheses.
> 
> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> ---
>  drivers/staging/xgifb/XGI_main_26.c | 59 +++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
> index 10107de0119a..aee969aab681 100644
> --- a/drivers/staging/xgifb/XGI_main_26.c
> +++ b/drivers/staging/xgifb/XGI_main_26.c
> @@ -544,41 +544,42 @@ static u8 XGIfb_search_refresh_rate(struct xgifb_video_info *xgifb_info,
>  	yres = XGIbios_mode[xgifb_info->mode_idx].yres;
>  
>  	xgifb_info->rate_idx = 0;
> -	while ((XGIfb_vrate[i].idx != 0) && (XGIfb_vrate[i].xres <= xres)) {
> -		if ((XGIfb_vrate[i].xres == xres) &&
> -		    (XGIfb_vrate[i].yres == yres)) {
> -			if (XGIfb_vrate[i].refresh == rate) {
> +
> +	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres <= xres) {
> +		/* Skip values with xres or yres less than specified */
> +		if ((XGIfb_vrate[i].yres != yres) ||
> +		    (XGIfb_vrate[i].xres < xres)) {

Both < and != are equivalent, but to me != feels more obvious.  With !=
the opposite of that is *always* == so that's obvious just by looking at
it.  But with < you have to look at the lines before so you have to
remember more stuff to understand the code.

The other thing is that != xres matches nicely with != yres.  Otherwise
I sort of assume from looking at it that != and < are different things.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
