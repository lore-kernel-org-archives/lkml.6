Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDFLyK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:54:10 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:38912
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752128AbeDFLyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:54:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 04:53:59 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, dnelson@redhat.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180406115359.GA14761@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
 <18c48972-ef34-5b14-f91b-0ceffc286769@embeddedor.com>
 <20180406114330.GA14704@localhost.localdomain>
 <b2288b61-09d3-0f76-23db-3fed10d3647a@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2288b61-09d3-0f76-23db-3fed10d3647a@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:404:f5::21) To BN6PR07MB2993.namprd07.prod.outlook.com
 (2603:10b6:404:a7::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97789e28-8177-4bd3-e022-08d59bb5183f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2993;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;3:k3glCXdMuPwwf42X2Ey0dI0bAQzKA8mw0KrMbwXPgpcehpSe9xiMReEaTzDyTNcLcPTR/6x4dhAUhPpVzV2ciHTJq4zFTNScS9Wyejrse7PeFJw/CE/2R9oz67qD0v168Pa8bTW5pAJ0Sm48HMMwJMuKwdclwHxbzButCqAtVUQhj729Suz4Emw5rmBB6wcl0w/O+CN9EM0CjyW2xMkE3gimzFBp+PKLPsN9QnxHQMiW92B7lDr7WbQfnUnmR0qF;25:SmkW+Sf8dhI8Fb2M/J92qmyu18NQsuRX7K+/1gVp3MkdrEQLcgrm/NbT+0xaxJOQVq/7isr9repuDmx5clii4fyATHJBt1pBqpAfNvFJMycsRNRbwwB0bIPNgHtxGXOADe2op3nhhPfwHNZGx5sBhmHBdinufvhRYNnomvsfRTROXoRB1RLUCzUNKxpVi2qKKykUX1i3tqVZgcRUnS2KAVbycg5D4+Hn+h13ZMTPRWo8BSSmMjLvq9oeUHEeXm/y6uJ5teXxlDg/jf3VnFlPMIShVJeiZSLX8xqIUqIqweOpyPhyHF01oGB2Ic8E7LqR8V53cgfWa4ByR0405eCecA==;31:qiPE/m4Ar1y/cJa+bJ+9zVWMoWn+co5uFPSlvYgXqV1w+UyjSUpSxC0gfELoNSuqfGQt+u3lnp0N5NxMg8fN2LPN91A6iNpOFVNpEdAjAFIzm24Q+/0Xq9sYwJjgnxe/LBYJKCpf4Zbo13JF5h/srN5g+mVNjSujTV/7FrBWTNcpg74OYm9cTAOO/qDBAsWJT+OY8hvwOjSXcHdw9nHzKLh70SSAwGIDEye5TEVRhWE=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2993:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;20:60LKzHeiEvD1FJHDaQbtrpUKmsVHyQFRyx+x860M7ixRgQ6Y05Oe+IVwM22zUA8qoYMY1YaqkEb3Wdl14zd04vRrupa7L2FOeQA6Fs5kwqXUoS6xcXewRfgxiCnlOuNFZaewAB3aE7Kpskxxl/tk0SDUXJ4B5/3H+cA29LbUIBvmXIlcTM4+g3dY/zNxbCRhRrR/CMueJai+wgxDTCjbmovzkXyosPwAhR2C4fPxS7JfrbjDPnI97QRn0SOvKZdcnKDvDCgd6FmbqCB/dVW8iMRzTt8RRadfq9GIg0/OJnBVD2Xc70oAExy7Oe3Rr/i6npTlEhUf5BI8f6mksEjb78kpb8hZm7k42SVbLgyp6QHJu+LW3OXGn+5EwCzQOYBDfFT8vjZfHseQw0cYbLmzJeI7fMN2hVOF0ovt2uK3UdLO/OG6pB3z6RUJOEVIV40BkQZlJpqp7oMgUK1UDL41RVrsBnBk36xx9SdfspCXAsLtdOMddSMT8HGwcqR/kCItoJjEFcpZGc77p5zUfKlyLiazWYxOIxqC2SUkWuUIOaRtmLLShuD1StPW4ChcORlnD1o/sTzcl/rIUcBUKZ4LuYmLUMvycWztr3Jp6xGr9Lk=;4:HTkC9fJqtB9J1znmBnAS9jVTWO49OBl/JoV5Et8a6g3x3y+6uwdlfDbDQ7oI7Ncaoa+gOqGWJLiWLh3rI13AqOhPpusZW5TyjdNfB1iErd5HGoIvv6BZreK4D+LM2wqxVtd4f1obAlytCaQqfYK2JTQTUnyc0MC6SDbUTlGdq/Okck68tAy/yhMkZgs30d9mYO+3psLz6CHWpDX9tmyweibJ/ekkOzCLDOTxjrt0vTxQkMIxstXHZrwuf0BvpeKM8IBFQoptyfQ9TRuK5w0pzBM+PasonC0lEJeCg47HTS6j1rtaBjduH8HW0AblMxTo
X-Microsoft-Antispam-PRVS: <BN6PR07MB29938A3BD8E95B72DC468C828ABA0@BN6PR07MB2993.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR07MB2993;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2993;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(39060400002)(55016002)(50466002)(97736004)(23726003)(6246003)(6116002)(53546011)(1076002)(16526019)(186003)(33896004)(8936002)(3846002)(6916009)(26005)(2906002)(58126008)(66066001)(486006)(16586007)(229853002)(386003)(316002)(6506007)(76176011)(59450400001)(11346002)(33656002)(446003)(956004)(478600001)(476003)(106356001)(5660300001)(7696005)(8676002)(42882007)(93886005)(25786009)(105586002)(81166006)(68736007)(72206003)(47776003)(345774005)(81156014)(305945005)(7736002)(53936002)(6306002)(52116002)(107886003)(4326008)(61506002)(9686003)(6666003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2993;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2993;23:3V650Vq/7nkx9+j/OFgdjWgIuS+gC7FCjPUoZgSF5?=
 =?us-ascii?Q?LNLWKRRzt+AYo4WqhCclNvOkFFhfplgZG4HsRU5xeIc+ruBU63P1pZdZROzV?=
 =?us-ascii?Q?goF291DjRx9RFtEX2uQkpOZGzJo7Tuw8v9inIcZoxIWfTu941OUvOvK3zDbX?=
 =?us-ascii?Q?r9SkTg6lzTUacNcwPY05i6Bb/kiDDC3LrLOfpDiDuOg1P+FuZWEgUjjz6+S5?=
 =?us-ascii?Q?QBROB+fbHSloR3gjkRd5AVJmhB5dBLp+/J7IwBXocYVKNpEOHgLKI2vtcH3Q?=
 =?us-ascii?Q?gZJ+4fn/6P8Ks70gjdH+c3oP367+TT5ox8bJVGdTO9gH4l93RRitbXJEqrab?=
 =?us-ascii?Q?U2gA0GNWzyaFePUVgduwIV8mI8oGTG7rPKSrF2gG8W57nlO5iytJYD/JIrGZ?=
 =?us-ascii?Q?6W1KHH68E2IsIhbw6dXayPqqTxykfbUv1h5nxlfiv6rbJwwLsSs8KVS/8UGa?=
 =?us-ascii?Q?PjUsm8ykSv1euEMxRc6JMgOH6azC0LA1Yl0nWlfomj4976YXR9Mlfjfd1GP1?=
 =?us-ascii?Q?AeJGVmfOWxwptpM3NRewYZBol/kSqVESDNC3e5Iycu33AGOZZytPCTvrRAM2?=
 =?us-ascii?Q?ebV+gIOZRCWcUid4Pz+pwMuSGQu75uHyFmznsSZCtV4kWaTMr390GZOuwqEi?=
 =?us-ascii?Q?WAYU21SyqJJcYwsfoZ+1N84kh3nEhR1LV5SM7uXuo26gDhbVX+rqtgREd+jT?=
 =?us-ascii?Q?UpAOlIXFC4EZoQTPbM+X/zDtFMQDyVDzcBTbppfSWnGPSaENhdOc1W7cYnuU?=
 =?us-ascii?Q?m3DUh+hLYU4J3etudPjhuoO6SK+FNoWIetpRm5t6OHRJtBa+AASmQTJv3u5B?=
 =?us-ascii?Q?0CZzY4gxltxaUnKATSErXIAraJzfpMYseIotdz/gPNUtfVt8AF8tVTf6v44G?=
 =?us-ascii?Q?dKGaEdvOVUcl7e93ZKo60207dL47URhCVOWFd2hgQsq7rdXnVJ594QNe55IJ?=
 =?us-ascii?Q?6KvDRzHpv4wBULUbapwtyQH7CADpNvgM7HJYgSKE+M4f4p18aep+X9M4T6qK?=
 =?us-ascii?Q?+xXnB1tpyPRkr0msa+PI+QxARyoir/1OOLcHUIhsHiAgI5ZT8h4yqKrqymp4?=
 =?us-ascii?Q?xU58PAzv8RYpg/ix/At9FebTyG4ZyQpfefPeyR5d/F4KYsdHQcGh/TffJN+f?=
 =?us-ascii?Q?SUfFSZT4hqPPE5l09PLE/lRn8WIzQrRcUFEKte7obG09gIGyao2BBOtJdCqJ?=
 =?us-ascii?Q?TXkO4ARGnWpZ35sz8K/JsDUB6qd4GA9BKCqCqnZO7adpkEtbzzzG+aMgQMt2?=
 =?us-ascii?Q?SjEKatpgI6Y9ZKTHg9yMZH3R/MrfeSqy2nNAcs17tWOyzELNYXJNClZEqPAA?=
 =?us-ascii?Q?pGLQ4fZa9xWh9OVP/UqSMXfIHLceJfQ9X4d0C8GayeU6yRizAP+5w1zDfaTX?=
 =?us-ascii?Q?P2WhM8zceoS/OBZ3AKcI5qcJbu3C3NKZPSlQCJuKMNf9OoliSozzehQPuvae?=
 =?us-ascii?Q?1uiFDHIdadVokZhaIhnhK+qZuLuLIwK4C2i4t9tkzC0LyXsJzbDhbBSf9dGR?=
 =?us-ascii?Q?UVWSNsijt/P5Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0lLhccj1WHVRQPn2UaY1mcNJKvmv9lq6WW5eivmTtHn0FDRgns+GAPzQPtZMpYTN54Ly9kS6DQYDlKWx4wOMJQF0UF/im8KLKt6OUUktVEUQGlg4868P0GsQIqI6CiqFe0qgb5exyg7Kh9W1iwLYo5PGGzfYMznY6s+looQ0FpW2BkekKD4xALWTt7cCF68m
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;6:MHvoXvyLerRXgD+AUMJvCmYVvvP5fRGPEXx5tLvpG6Q2kjdRVKxTfa9AJtPG2lTFwY7wJcGLszjDXB/wMjuw/Al45EwTx54T+RyHR/OMYGLGR7PrhxSz7pLAW16mJ0LvPS2fAeOIjGRplWWkiCMt2EUvfI12DGzDGDTtPRRXHuaihemLlT3hhyyfWSATDSrJbWiz/ES2Ave1LJchtZJwOaQn0G+gZBNapWh5SjBgDEfa2ZmfydDGxiSK8DANPDqNaQSbbvolQ0DdFqdDIcy6GzWsZWotVXIeRnEJwK+gPgJK3Hvlp5dIZXXkW0imenZbciJNcmKmeUIfb3yL18WV2ATmmxdaUb0wDvEkk6MhY8X+uUP3UGFvQ69RpwYEADDoHue2DFJkcxc6z0NftOTqVEfEuyi8cvNQUNUmkrp4PGRcc3AIl6j9poNXkJxWswFxN8RHo0dYQ1R3N4wxD6pl2A==;5:+5k+PQwOJpfjpjXp1+dmG/ItOHzBUPAndZijbrWNWdeHdyUrGBJUZol4gtPLiGRTHBe18Ek3lQdtkoZejlXhUxKKxZ/HY16cPXjMPdJqO0rIm5Uizw88eE12+i0OujVdXQw27Ri0fLRcMlNMZCYyb7b7rfHrlCx3a2TSoYXF/Zo=;24:HHla8tCblZcN0D7J3EaIJ1z4IVCoS4bOoP4Xj63Za9KakOt3x8K3bOhZuLauGVG83xgxMwTjDVk9RirJYPvtaasXUQibxVVvzQn7zce4jTs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;7:c7lcAzVBK5EPIkQ2qwBrBLHWsS35s6TjoLTehZ3//3vD+HL4/aSzXuiU7ftR4wnyNi6OOkakA21Zxh3T3bSK0M/IvSdo0qraztKuSkaYhuqSjoAQaVcMsAFk/7nKZ6lg7mXTH3QDxRnI7bpjTa21D+ouA3dNGM7aQZ38FY8n2pjbVQpe/wWKAlc28NkH4edBB1VEOkbdvn54UtohwgXGF6J5eKaQUgLCRx72j424Pmlxu+sC+6CODnJK7zQAuqDw
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 11:54:03.1880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97789e28-8177-4bd3-e022-08d59bb5183f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2993
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 06:47:26AM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 04/06/2018 06:43 AM, Vadim Lomovtsev wrote:
> > Hi Gustavo,
> > 
> > On Fri, Apr 06, 2018 at 06:36:28AM -0500, Gustavo A. R. Silva wrote:
> > > Hi Vadim,
> > > 
> > > On 04/06/2018 06:14 AM, Vadim Lomovtsev wrote:
> > > > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > > > 
> > > > It is too expensive to pass u64 values via linked list, instead
> > > > allocate array for them by overall number of mac addresses from netdev.
> > > > 
> > > > This eventually removes multiple kmalloc() calls, aviod memory
> > > > fragmentation and allow to put single null check on kmalloc
> > > > return value in order to prevent a potential null pointer dereference.
> > > > 
> > > > Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> > > > Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> > > 
> > > It'd be nice if you add:
> > > 
> > > Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Ok, I could do that.
> > 
> > Just to explain .. I didn't do it yet since I get such report from
> > Dan Carpenter intially (https://www.spinics.net/lists/linux-kernel-janitors/msg40720.html)
> > and was working on it when found you patches, so then asking you to give
> > me some time to prepare and test update to driver.
> > 
> 
> Oh I got it. Not big deal. I think in this case you should add Dan's
> Reported-by instead.

Ok then.

> 
> BTW nice patch. :)
>

Thank you for reviewing it.

WBR,
Vadim

> Thanks
> --
> Gustavo
> 
> > So would it be acceptable put two tags 'Reported-by:' then ?
> > 
> > WBR,
> > Vadim
> > 
> > > 
> > > Thanks
> > > --
> > > Gustavo
> > > 
> > > > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > > > ---
> > > > Changes from v1 to v2:
> > > >    - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];
> > > > 
> > > > ---
> > > >    drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
> > > >    drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
> > > >    2 files changed, 11 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> > > > index 5fc46c5a4f36..448d1fafc827 100644
> > > > --- a/drivers/net/ethernet/cavium/thunder/nic.h
> > > > +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> > > > @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
> > > >    struct cavium_ptp;
> > > > -struct xcast_addr {
> > > > -	struct list_head list;
> > > > -	u64              addr;
> > > > -};
> > > > -
> > > >    struct xcast_addr_list {
> > > > -	struct list_head list;
> > > >    	int              count;
> > > > +	u64              mc[];
> > > >    };
> > > >    struct nicvf_work {
> > > > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > > > index 1e9a31fef729..a26d8bc92e01 100644
> > > > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > > > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > > > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> > > >    						  work.work);
> > > >    	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> > > >    	union nic_mbx mbx = {};
> > > > -	struct xcast_addr *xaddr, *next;
> > > > +	u8 idx = 0;
> > > >    	if (!vf_work)
> > > >    		return;
> > > > @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> > > >    	/* check if we have any specific MACs to be added to PF DMAC filter */
> > > >    	if (vf_work->mc) {
> > > >    		/* now go through kernel list of MACs and add them one by one */
> > > > -		list_for_each_entry_safe(xaddr, next,
> > > > -					 &vf_work->mc->list, list) {
> > > > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> > > >    			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
> > > > -			mbx.xcast.data.mac = xaddr->addr;
> > > > +			mbx.xcast.data.mac = vf_work->mc->mc[idx];
> > > >    			nicvf_send_msg_to_pf(nic, &mbx);
> > > > -
> > > > -			/* after receiving ACK from PF release memory */
> > > > -			list_del(&xaddr->list);
> > > > -			kfree(xaddr);
> > > > -			vf_work->mc->count--;
> > > >    		}
> > > >    		kfree(vf_work->mc);
> > > >    	}
> > > > @@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
> > > >    			mode |= BGX_XCAST_MCAST_FILTER;
> > > >    			/* here we need to copy mc addrs */
> > > >    			if (netdev_mc_count(netdev)) {
> > > > -				struct xcast_addr *xaddr;
> > > > -
> > > > -				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> > > > -				INIT_LIST_HEAD(&mc_list->list);
> > > > +				mc_list = kmalloc(sizeof(*mc_list) +
> > > > +						  sizeof(u64) * netdev_mc_count(netdev),
> > > > +						  GFP_ATOMIC);
> > > > +				if (unlikely(!mc_list))
> > > > +					return;
> > > > +				mc_list->count = 0;
> > > >    				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
> > > > -					xaddr = kmalloc(sizeof(*xaddr),
> > > > -							GFP_ATOMIC);
> > > > -					xaddr->addr =
> > > > +					mc_list->mc[mc_list->count] =
> > > >    						ether_addr_to_u64(ha->addr);
> > > > -					list_add_tail(&xaddr->list,
> > > > -						      &mc_list->list);
> > > >    					mc_list->count++;
> > > >    				}
> > > >    			}
> > > > 
