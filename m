Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeE3TVx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:21:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeE3TVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:21:49 -0400
Date: Wed, 30 May 2018 22:21:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Al Stone <ahs3@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mailbox: PCC: check for negative count for parse
 failure checking
Message-ID: <20180530192119.eexpge4nke4uovlz@mwanda>
References: <20180530171429.3172-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530171429.3172-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=620
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 06:14:29PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function acpi_table_parse_enties_array can potentially return a
> negative value if parsing fails. Currently the check on the return
> is not checking for errors, so fix this by adding a -ve check too.
> 

The impact is that kmallocs would immediately fail and give you a big
stack trace.

regards,
dan carpenter
