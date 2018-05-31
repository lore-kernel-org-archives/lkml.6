Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbeEaHF4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:05:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeEaHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:05:53 -0400
Date: Thu, 31 May 2018 10:05:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Colin King <colin.king@canonical.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bpf: devmap: remove redundant assignment of dev =
 dev
Message-ID: <20180531070518.obnfw5tv23sbpfys@mwanda>
References: <20180530150916.16808-1-colin.king@canonical.com>
 <20180530210713.v4cf4wjniwyobfmm@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530210713.v4cf4wjniwyobfmm@ast-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805310079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 05:07:15PM -0400, Alexei Starovoitov wrote:
> On Wed, May 30, 2018 at 04:09:16PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The assignment dev = dev is redundant and should be removed.
> > 
> > Detected by CoverityScan, CID#1469486 ("Evaluation order violation")
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Applied, Thanks.
> 
> Please use [PATCH bpf-next] in the subject next time.
> See Documentation/bpf/bpf_devel_QA.rst

Guys, be reasonable...

git log --author=Carpenter | \
	grep -A1 "Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>" | \
	grep -v Carpenter | grep Signed | cut -d '<' -f 1 | sort -u | wc -l

I have sent patches to 206 maintainers.  It doesn't scale for everyone
to have their own special document for sending patches.

I asked this last time, and I even skimmed your document, but how are
people supposed to go from linux-next to the correct bpf-next git tree?
It's a pain for me to do this for net, but net is way larger and busier
than any other tree.  I know it's a bit rude for me to say that you guys
are not as important as net, but that's how I feel.  I'm only going to
report bugs instead of writing patches if you guys are going to insist
on all sorts of new rules.

regards,
dan carpenter
