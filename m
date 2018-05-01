Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeEAMBa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:01:30 -0400
Received: from sesbmg22.ericsson.net ([193.180.251.48]:51344 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeEAMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:01:28 -0400
X-AuditID: c1b4fb30-0dfff70000007681-e9-5ae857154489
From: Jon Maloy <jon.maloy@ericsson.com>
To: Wenwen Wang <wang6495@umn.edu>
CC: Kangjie Lu <kjlu@umn.edu>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:TIPC NETWORK LAYER" <netdev@vger.kernel.org>,
        "open list:TIPC NETWORK LAYER"
        <tipc-discussion@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tipc: fix a potential missing-check bug
Thread-Topic: [PATCH] tipc: fix a potential missing-check bug
Thread-Index: AQHT4QSepsg7SNyeDE2wQK/XNU8Hd6QavkyQ
Date: Tue, 1 May 2018 12:01:22 +0000
Message-ID: <BN6PR15MB1553F08DDF8D0F1356AA72EA9A810@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <1525148761-11091-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1525148761-11091-1-git-send-email-wang6495@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1170;7:pjbeJm1pB8vWdahiC/IuW2W4sMAqlfO740uLdKIHScMlXKaJKL1skKDlVpfTxJz/+SP9eL964W58hGyxNXjOuttI/B/cxelu8br93B506VOEuB47ZITMn5bHT+49yTJnjtAGefKHdrWuW2/ITesIeFX8R0ToaXYpUX+FfhLX8liwqVV5yIeIAOWWPW0+FaJvxuKfs8VEb3RQ7+gJbaCS0/5+1abuYBFJ4hX0xu/V0E60+mnfukPKL7CuCIvuQIoq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1170;
x-ms-traffictypediagnostic: BN6PR15MB1170:
x-microsoft-antispam-prvs: <BN6PR15MB117094F84D5F771EDB3CA97E9A810@BN6PR15MB1170.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(192374486261705)(9452136761055)(42262312472803)(8104003914727);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR15MB1170;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1170;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(376002)(346002)(39860400002)(13464003)(199004)(189003)(55674003)(3280700002)(25786009)(81156014)(6916009)(476003)(8676002)(6116002)(305945005)(186003)(8936002)(2906002)(59450400001)(7736002)(81166006)(5660300001)(3846002)(486006)(54906003)(74316002)(3660700001)(316002)(478600001)(44832011)(229853002)(7696005)(2900100001)(446003)(105586002)(76176011)(53936002)(53546011)(55016002)(2171002)(33656002)(86362001)(5250100002)(6246003)(66066001)(68736007)(6506007)(26005)(102836004)(6346003)(106356001)(6436002)(14454004)(11346002)(9686003)(99286004)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1170;H:BN6PR15MB1553.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-microsoft-antispam-message-info: QTXv82jcGMqLUBcZXtofmjvXlDOat6H0OnMJ6VKgjZ8l0N9hL9ppPIPuHNJrhLWrmhXnmLttmYHZ3tHw21Y7VY9Vl+96qQYJphTLxsKgToBDQRRZs+tenaSKasc2BZM0O5xvWxXSOfmDfnJxjvSbUE4gtZE2rEyI6UO1GBw5ZVMjj0tXsVtJJP5wrFtCFijK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b1f42af4-b6f0-4a03-1b22-08d5af5b422f
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f42af4-b6f0-4a03-1b22-08d5af5b422f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:01:22.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1170
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTURjufJf5ORqclpcXS8HRj/Cu9GOJinZdCBJUmKOwpR9q3jeVlCAz
        MzEtkVlpK6eluDBTNzU1BDXFhmZoeSlJSldOC23iJUvN7VvQv+f2Pu954TCksJ52YuKS0lh5
        kixBxONTZWdbXTwdwmelPjlv+WLVUC4l7n80aCMeaVfxxH1qB7Fu6JJYr/9Ei6fHxshgG4lO
        M0FIOtRLhOR9ZY6NZKnJRfJc10ycpKX8gGg2IS6DlXsHXeDHKucmeSkPHC/P1hjobLQhLEC2
        DOAD0PNTRxQgPiPErxDczl224YgWQevn61ayjKCpuB9x5DEBRo2WNhMKmwgYGJiwxkoI2Ghc
        JDnyBUHzsppnXsPD+8F4Nx+ZsR0WQd5ovmWcxCoC1lXztNnYjQNgoW+K4EKBoGys39aZbewH
        64NSs0zhfXCnqNYSF+BzMNo1ZekU4mBoGChE5rgtDoH7Bg+zjLADrOrrLI0kdoQPMxUEdzWG
        Jy+HSA7bg3F6k+awKww1VFl1ZxiuuGU5GbCOAMNIr3XYExZLS0nOaEHQudLM4ww3mChutjbF
        Q8t4Oc2FChBsLd+0VlWTkP+xhOJSe6HfVEQXI9/y/57IYQ9Qd5h4HHaHmsp5stxy9S54XTZD
        qRH1FNkrWMXFxBg/Py9WHhelUCQneSWxaU1o+xd16X77vEDGbyHdCDNItFPQcGRWKqRlGYrM
        xG4EDCmyE2jyv0qFgmhZZhYrT46Upyewim60h6FEjgJxmFYqxDGyNDaeZVNY+T+XYGydspG3
        p2Zae9y7LVU1UfhsnDqm9DvvpDEc7TrofyL0zbV2/9XQ9JbYtULRGX11aGrt5q/ww7ecTfVh
        c1Rej7s0MGAy5aEgfkX77oomPIxfFWc7m6Ks61w4pbzx409UxOlIg0Q5nLe2QxAws9bb1phu
        Clv/ntPS55p9aCvr3tWgiPIijYhSxMp83Ui5QvYX7iN1/kEDAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41C1Zo1021149



> -----Original Message-----
> From: Wenwen Wang [mailto:wang6495@umn.edu]
> Sent: Tuesday, May 01, 2018 00:26
> To: Wenwen Wang <wang6495@umn.edu>
> Cc: Kangjie Lu <kjlu@umn.edu>; Jon Maloy <jon.maloy@ericsson.com>; Ying
> Xue <ying.xue@windriver.com>; David S. Miller <davem@davemloft.net>;
> open list:TIPC NETWORK LAYER <netdev@vger.kernel.org>; open list:TIPC
> NETWORK LAYER <tipc-discussion@lists.sourceforge.net>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [PATCH] tipc: fix a potential missing-check bug
> 
> In tipc_link_xmit(), the member field "len" of l->backlog[imp] must be less
> than the member field "limit" of l->backlog[imp] when imp is equal to
> TIPC_SYSTEM_IMPORTANCE. Otherwise, an error code, i.e., -ENOBUFS, is
> returned. This is enforced by the security check. However, at the end of
> tipc_link_xmit(), the length of "list" is added to l->backlog[imp].len without
> any further check. This can potentially cause unexpected values for
> l->backlog[imp].len. If imp is equal to TIPC_SYSTEM_IMPORTANCE and the
> original value of l->backlog[imp].len is less than l->backlog[imp].limit, after
> this addition, l->backlog[imp] could be larger than
> l->backlog[imp].limit. 

It can, but only once. That is the intention with allowing oversubscription. This is expected and permitted.
At next sending attempt, if the send queue has not been reduced in the meantime, the link will be reset, as intended.

> That means the security check can potentially be
> bypassed,  especially when an adversary can control the length of "list".

The length of 'list' is entirely controlled by TIPC itself, either by the socket layer (where length  always is 1 for this type of messages) or
 name_dist, In the latter case the length is also 1, except at first link setup, when there guaranteed is no congestion anyway.

I appreciate your interest, but this patch is not needed.

BR
///jon

> 
> This patch performs such a check after the modification to
> l->backlog[imp].len (if imp is TIPC_SYSTEM_IMPORTANCE) to avoid such
> security issues. An error code will be returned if an unexpected value of
> l->backlog[imp].len is generated.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  net/tipc/link.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/tipc/link.c b/net/tipc/link.c index 695acb7..62972fa 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -948,6 +948,11 @@ int tipc_link_xmit(struct tipc_link *l, struct
> sk_buff_head *list,
>  			continue;
>  		}
>  		l->backlog[imp].len += skb_queue_len(list);
> +		if (imp == TIPC_SYSTEM_IMPORTANCE &&
> +		    l->backlog[imp].len >= l->backlog[imp].limit) {
> +			pr_warn("%s<%s>, link overflow", link_rst_msg, l-
> >name);
> +			return -ENOBUFS;
> +		}
>  		skb_queue_splice_tail_init(list, backlogq);
>  	}
>  	l->snd_nxt = seqno;
> --
> 2.7.4
