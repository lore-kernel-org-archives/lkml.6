Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1132802-1521016293-2-4802023663493296549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521016293; b=M6F2Of0f2sgXw9t8ZQ7LQDHoPKVFiqcP+0nbJELLl2bQ0wx
    mBvvXyvUskUEpNTEs0/eC1nwTgYVi4Hbtsmv/PeT55jVHF6IAsdQeayLeHuLHCJc
    ZjwSouV1jKvAG6I0x/7DJLKkfQYEUB7n/j8lmBCv0y2BS7NgqqjQB8ySEq1JRqnX
    90EV6Yqk446RObqJ1/j0TwbBbg8PCUbUuz07AyKd8R1YtYdCjIpy5hUplpwiZw/J
    WqAzHS8dfWF0Ghq5quZ80I3MXsIgU1xfODDwIeX+hsrfl2b3idzezMKpXV/4irkc
    SQPIsQpV2DxAw0wk5xTZjMtaJ78fZyeryBVpHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521016293; bh=S
    rA6wuHOFRklI4LaFxhr0qRmwCOQflJH5dZFEwoGs7c=; b=s/UGVDn4RnnSYzJ7y
    Gn2kRSEvtT7BsX9l8UHxBS4UyDm5ir14O80c/oGnvLHd+kG+8mGOOFqZIWxmQXYQ
    aQyr8c4K5Py636jbOkDUIMWvcYBNFoPPHXIzsXfoyw0nJ+ldM5+1rMh6vWLqXJqz
    PUVvPysPAuKUeWTcY9d2lGtx35Hy1hY0SRj1n6kw+mj3yzAyY4De3fBFofNe/c5o
    8RkxCRiSz8nWqTa7Td79YUOLL5I6p3nUUfLJssRBSEggzio5PAAZDVetCKicUG4I
    6mjAq63+a5bxhvAEP7DV059uI92OJUNKC0gtoY0nfwb9n11r3n+bZZXWXwZYV3kI
    9CQFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KvoeV+qW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KvoeV+qW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 11:31:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Message-ID: <20180314083115.rftkeucwzajs7qaq@mwanda>
References: <20180313200054.31305-1-ps.report@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313200054.31305-1-ps.report@gmx.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140099
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need a changelog.  How does this affect user space?  What bug does
this fix?

On Tue, Mar 13, 2018 at 09:00:54PM +0100, Peter Seiderer wrote:
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
>  drivers/staging/media/imx/imx-media-csi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5a195f80a24d..3a6a645b9dce 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -111,6 +111,7 @@ struct csi_priv {
>  	struct v4l2_ctrl_handler ctrl_hdlr;
>  
>  	int stream_count; /* streaming counter */
> +	__u32 frame_sequence; /* frame sequence counter */

Use u32 because this is not a user space header.

>  	bool last_eof;   /* waiting for last EOF at stream off */
>  	bool nfb4eof;    /* NFB4EOF encountered during streaming */
>  	struct completion last_eof_comp;

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
