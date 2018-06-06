Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2FFD606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeFFMco (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:32:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750795AbeFFMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:32:42 -0400
Date: Wed, 6 Jun 2018 01:07:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: atomic_ops: atomic_set is a write (not read)
 operation
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180605194326.23596-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605194326.23596-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060612-0068-0000-0000-0000030434A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009139; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043027; UDB=6.00534142; IPR=6.00822157;
 MB=3.00021491; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-06 12:32:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060612-0069-0000-0000-00004496BE33
Message-Id: <20180606080756.GU3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:43:23PM +0200, Jonathan Neuschäfer wrote:
> Describe it as such.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

I have queued this, but if someone else would prefer to take it:

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  Documentation/core-api/atomic_ops.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
> index 2e7165f86f55..724583453e1f 100644
> --- a/Documentation/core-api/atomic_ops.rst
> +++ b/Documentation/core-api/atomic_ops.rst
> @@ -29,7 +29,7 @@ updated by one CPU, local_t is probably more appropriate. Please see
>  local_t.
> 
>  The first operations to implement for atomic_t's are the initializers and
> -plain reads. ::
> +plain writes. ::
> 
>  	#define ATOMIC_INIT(i)		{ (i) }
>  	#define atomic_set(v, i)	((v)->counter = (i))
> -- 
> 2.17.1
> 
