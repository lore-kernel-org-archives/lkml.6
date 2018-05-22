Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEVRD4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:03:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34565 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751240AbeEVRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:03:53 -0400
Date: Tue, 22 May 2018 10:04:33 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Pen <roman.penyaev@profitbricks.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        swapnil.ingle@profitbricks.com, danil.kipnis@profitbricks.com,
        Jinpu Wang <jinpu.wang@profitbricks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/26] rculist: introduce list_next_or_null_rr_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
 <20180518130413.16997-2-roman.penyaev@profitbricks.com>
 <20180519163735.GX3803@linux.vnet.ibm.com>
 <CAJrWOzAt8BDtypaRwYx_y9jpCVD5W_VL9aQsFsC3bL-XaoJz9g@mail.gmail.com>
 <20180520004318.GY3803@linux.vnet.ibm.com>
 <CAJrWOzBenkHg_5zs1VAxP_rVbCbOJO_eO0toJBhnzXuy_yWH2Q@mail.gmail.com>
 <CA+55aFymFCVqh4VxtqDPoFYh6zsGEDLSV79_AnsMp3M=t2mhqg@mail.gmail.com>
 <20180521153337.GF3803@linux.vnet.ibm.com>
 <CAJrWOzDfJ46Vwz5k7VgUwz04EzCCUtt57jxCx1RC0LoOA3t0AA@mail.gmail.com>
 <CA+55aFx+4D5bBYSKb5jKjJ8SP=osGB=PCf8vW3RZH+R5fp5jgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx+4D5bBYSKb5jKjJ8SP=osGB=PCf8vW3RZH+R5fp5jgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052217-0024-0000-0000-00001875B14E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036093; UDB=6.00530004; IPR=6.00815222;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 17:03:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052217-0025-0000-0000-0000501A3AC7
Message-Id: <20180522170433.GX3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 09:38:13AM -0700, Linus Torvalds wrote:
> On Tue, May 22, 2018 at 2:09 AM Roman Penyaev <
> roman.penyaev@profitbricks.com> wrote:
> 
> > Should I resend current patch with more clear comments about how careful
> > caller should be with a leaking pointer?
> 
> No. Even if we go your way, there is *one* single user, and that one is
> special and needs to take a lot more care.
> 
> Just roll your own version, and make it an inline function like I've asked
> now now many times, and add a shit-ton of explanations of why it's safe to
> use in that *one* situation.
> 
> I don't want any crazy and unsafe stuff in the generic header file that
> absolutely *nobody* should ever use.

Completely agreed!

I was perhaps foolishly assuming that they would be making that adjustment
based on earlier emails, but yes, I should have explicitly stated this
requirement in my earlier reply.

							Thanx, Paul
