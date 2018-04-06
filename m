Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDFLnl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:43:41 -0400
Received: from mail-by2nam03on0083.outbound.protection.outlook.com ([104.47.42.83]:13927
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752489AbeDFLni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:43:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 04:43:30 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, dnelson@redhat.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180406114330.GA14704@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
 <18c48972-ef34-5b14-f91b-0ceffc286769@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c48972-ef34-5b14-f91b-0ceffc286769@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:404:79::19) To CY4PR07MB2999.namprd07.prod.outlook.com
 (2603:10b6:903:d0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89c56a13-7e34-4a2b-938c-08d59bb3a293
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2999;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;3:S3Dq4C5g45estaVjMe3iz3B3WEa+8k7Uj9LgFIx1LB5cfQy3InsbgLOarn5a8tBZhBNDr6KlzK9LwVXdOqEedJnrErCZKBOIJWfQROpjDsjxM8k4ZsiGgUNd1slZFVh1hEUTyPsQH2TTEUbIOR47qF1sn4sUfwj3IQZ9Lx+ZyeLRpp4ZIdO+pBZ4BvOrt4j+Q/2B2YsS4yQwrPQ+cKWf0beDJVNEPiOBqskb6l8piwy+SXPDyLjM022EWuW3Wkj9;25:pl+BnAGtnyZQi7vzt10956Sx078sJU1UafF/ABGuV31lqBWpz2w/+nXglwsOgTnMTsGXIxeeg/XX96Gn3RhwwwZzgEI+GOpzwPlRFlfHKEzd2rMmF+5lhKKJGtf4erKsHGz08CEeVNUQtDkC5tmOjU08/F7V7gRdknwcijAfenZrWCi0y//p22a1rX9HYpLlYGIU5H34/6IcQ9KR+EU13ZMfD3IjtI5deouECXc5FfdsC+CoCDddqOiQiB6WcT6B04qkp+513kuLRgggbX8WN7sqpLFejl2X69Xd8MQ1BltR4lKEwSwf0tvhQf4ndD0zoz2JGZobxyNUetbKifZXhQ==;31:kkFBphy5GJaBmzKzCiwWC72/t1F/0Gb5Je72qmT/nnLiiL6IeJCw/RagYYFOLkGlVQx14dvfmfJhkT9j0XZKaaBKE2fcGrU7uaPIu3Er5N8X0EjffhAE/LTPOUY5jiLjtSc8TZ7fVcYaAr/mwQnKVCPdn35/Arfa/VzlgMQ78Alei4M31kIkUsmRYu9PkMIA/tw4KcltW18Ugt4Z5bea/pheAzyz+ysGbtfe0spXjig=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2999:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;20:OaiGAFs8LLokH0y8IkrGDaHhrVAA8YvAAS4Ro74jRHy+eB3H1aQdmCMl/V/fBpwA2vdrykoGTysg5eHgIA6DlC8Z5oyVmiESw+r4JfDJpBSqA6Hfs5q5bbM/VhIAS9jzOmiQSkXK+7hD1vvmGrrv8dx2ncB4GXSDbnyh7nvyQNWBg6BMWokBX6mNwK2jX5TIYXstznufxYZhifgEFY8csZWghyvELpNh24hqVQ/oJhFoUnoEzMFRUNbQkpYxh2N5FTZt6wBtWg774KN3YgQiv2QlAYA4dBVOg0bFLmKg2sBT9ntIcVIMEGfkCqKYHK8mYxbalGSOwrKRSbTyREXTxEwtJbkNlZpyfssOtPhGRj07UxGbLndV1+fjalQ8XzBcg2hbOFhazF+EpGTgSch0n5GuaD8nTfIRjZdGwSES4Bn9iy689GQlc7zt9v3C+u8vlo+GwFoivBjuaVtcWN6AOYo2TVXks6ae7rErbxolOpau8WGzATBIaXKGZk6lzLl1ZsE5jkTNT4Sft5RdIBuiTGEQOtwMw3KkSOyWfs5gCH6b3xoq3Lat7egRR7xxKycC00oHHqdaPW2NG3JHOFzp/M1EnTY+kN6oRqjggtuCass=;4:hQLxX7UkqvAq58rfWiFBHPOe9qvf0SfY7GIHZbUC5hpazmDKWvdXgIBwf2ZB15eTyS4yGkVp47orylK45sZAndpf0iONRFCGZFW1AgJuEVpgdJCnp3cam1VkV7VBq6Cw6qTXGnLqslB8Go9HpWbIC+/SQQFuFAJRz3cthuwN1TgLNTun/hClXf9HAKUIskjjGIAq7sL+6TXU+RIGOcrsKaup9185bnqzkPKL8GXH7dVsOOMHaJiD7wU6AK000rY1hw/axBGjRYPzfGY2KpVbNFhMv1x8Qv1zacV/lrLxjFpzaA5tcVkbRi2M8iWu8mGv
X-Microsoft-Antispam-PRVS: <CY4PR07MB2999AC672988646C0CBC11F88ABA0@CY4PR07MB2999.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR07MB2999;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2999;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(42882007)(6116002)(53936002)(8676002)(6666003)(47776003)(72206003)(8936002)(50466002)(105586002)(478600001)(25786009)(97736004)(5660300001)(66066001)(39060400002)(61506002)(81156014)(81166006)(107886003)(2906002)(305945005)(16526019)(76176011)(7736002)(52116002)(59450400001)(446003)(11346002)(386003)(4326008)(7696005)(6246003)(53546011)(23726003)(3846002)(26005)(68736007)(33656002)(106356001)(6506007)(486006)(58126008)(33896004)(316002)(186003)(956004)(6306002)(229853002)(55016002)(6916009)(1076002)(9686003)(476003)(16586007)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2999;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2999;23:lvjx722g0r+t2SL9U0wV0VjL65Q+ePBDRtlFpgE96?=
 =?us-ascii?Q?BpVWfJfeXK2Mi6SQGKkHUA0+TLRqIBBQFqGCopcDOW8LXmh79/0/ZHxGV/dd?=
 =?us-ascii?Q?vWePtxRHJam1JoPBVopwPusas3CCsoB3Gdx4YrG2IjE5gpL/9YjuyjWyIPGB?=
 =?us-ascii?Q?PqiOmgrd5j393GExNNDYxBRkpG1FBwmCZc6fu1MYDOi8xx5AJ1hdvMjYgZK1?=
 =?us-ascii?Q?qNRNJJl9kZzCeo2YbTi4Kxy3cGLpkqaqPw887ruDHeugyRy8I+ItYnaGpgjW?=
 =?us-ascii?Q?JkKdK7zRuf6lJM6R4cWeZ4bbhZLmG7ySpDGJlMbrUp3pWk0IEaPQEeSx8B/5?=
 =?us-ascii?Q?FacNa4ASu4Bz0dOUe8Ogu0tnbpVOsdsDHv8o2hoxSwnIKOr4nr0628ajJJsY?=
 =?us-ascii?Q?xCCa5BmiMTvdi3/R8ECV5ePlocp0q07OGECxZXNpYQEyzskY8WiB5qYQLtjZ?=
 =?us-ascii?Q?KWwmW7HpMutTuKj6d4pfWf2RPiACZhta9vovHu535XVq5hRo7uqmUuWJfy5T?=
 =?us-ascii?Q?mXFUscoWQTeCdQa5AUe5db/7WL4tJO4c8/cTFNHaADJSSCmRXFrbUluNnbRR?=
 =?us-ascii?Q?HQ0exvBeG+ssFW1LbqUc3E8iVy7SernzAfvTfTIhVIomfW5hQa5ZemV2RWBB?=
 =?us-ascii?Q?rkbSaiQplS+7hYC7C0v6GcJfLlAnFf5Hesbek5AoKR5VpHD9yu90IPJJ6J6U?=
 =?us-ascii?Q?5IukGJw0iM4aBTZBGj7KnwKOsnds993R1mKjFruDo40JwnexCaW8XV/IVQvx?=
 =?us-ascii?Q?+5fre3wzvES06shEj1yYFtHjUSoGAjjUwVjlAC2YviBj+6TRaQx90TduIjFD?=
 =?us-ascii?Q?a7bb7xjt9vcXyOBxWT7HA6v8XzwXoT7Fd464fGva/zrS44LcmQTBVKl5qj5j?=
 =?us-ascii?Q?yJEWtnoJPl1zsgcCQiKuUNvr4GBcOWIlE+rzjpFUpkfSmhxZbSteeR35aW23?=
 =?us-ascii?Q?5X65+o5y45cWdlmvtIaOfLGbxIS7nqSjqjBcOO/uf7OEMVlloOqf10zvoyAY?=
 =?us-ascii?Q?9tQ/aUgO5eui/IkkCchcUYi0Ib0x68bUNluMyWBWANy38pMUGzxDlYbuwR5R?=
 =?us-ascii?Q?hfhiQgPX+sJuxD1uWsDWnu/3xZ1B8YHx2suAjHzCVUcVUsmctk/tB+Yn2Fzd?=
 =?us-ascii?Q?Pa5wOwuOI0MoHzJrF+TSOoQBmdQ4lsb/g9bVy8SEuHosMZD/cdSpElhoyVJ8?=
 =?us-ascii?Q?Y3UT1liK/torfDxV8XF9K97+BbLio9oG+SCxWI2bZhAymzXLksQ7Jelchit6?=
 =?us-ascii?Q?t+ph7TLUn466VotfsKpooAGo5rXGcZp1U2h0bA0kiLUS3eLh7IVgbEgRUOAV?=
 =?us-ascii?Q?fuLKmBGv/WwK4rdXdGdDGc92vjDKUmJrBAisV8VZtgfetgCJ/DfmNAD0OiQg?=
 =?us-ascii?Q?GLwJmxi/ie6NYugtU4zNqotboVBnNFnqPPQlqCJOGAUZQSaj0nukgpRIuBxx?=
 =?us-ascii?Q?tYvfj842OEgqHa0I5Tnsb2fw3NFSDI=3D?=
X-Microsoft-Antispam-Message-Info: ogegiEdE4n51XDeUIROIfJFgkdDoD2t+CpLpXZSI5+Yv/kNOUoEulQufDsNlL6BC+V2/qQlqaN7WAF1SUvPwTWCmuUI3a4OGk/MUqEOOFQjqP9gZS0VARV0cyeLnChilRomuv13JjlfPoVEI5rfqbIQsHfJohULK0Ww61rT+eB77dxEnVdZMlGvj4yr3IDuQ
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;6:9R5cjSuXyFls4cdjBRC2ZnnjQKaYK0xBJqwnXrpr5qEiWjJpKzT4Iuit5mwPMMO5/I7lzLyZVSEP1+ybeH+3gVcCrxWvRtw5RNqPGEfOvx1U6S8FBH4JmBPPrj92xvbfCz5+/ZHebg6Wj3AF5xUyLzipCVmEsJuRPB+QU7qp/MovL27Hlk6CsOe3o0q4cXq+qZ1PSEo2N1PiRrn+5KYRXTOWnp2UuPrYPbMBLhNrvmWOpFq5zyunv/zGQkYjMs31T4zdnXJlvDCbI8i9thdIR1ow1z1uomTvKK3zMBJgVRBLfcUHTu5CflirNlGikEpczlC3fAfLDvN3muMHG4zKVCAFDyb6nEGSniwnToHVXTUzqnbIuPIl1h91dB6jRzz6AhoiXDA9kIMn1BPdjtSN4wu17NLpxU4fEzNj8DMUiSDMX4zjk556ZVbteF5rRRbMg+kZF9WlOxOztzHbUWaA6Q==;5:mH9FFJiQqkFrAUDYOIERxmSWEvlmbY1yPBpXfUsrXEjV3dsS0LFWuzXnzHhSwUGYSsAmCUqNAnux3aU1ycuNcCk7tgFGHEbfqk7UIZnMgAxZs9rHwJfUxdRYQlDC/UEUxAMx0PxL437Hoky9WTj2T9KffQQ4g66BrtpMnHR5y24=;24:2r1OLZpmd+J1wdpev+U5Ngouj3QlRnrkOKZeb1dmb1ygPsSVINfhp+OByTQBJYOzL+D+gyTGrQjTELoT5IYm9+Cat82gLJIcQyyLpsJLC6A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2999;7:JBbXOhSNBwlLbRjtIWYzPTDyYvyzX+TY66yyA46thsT8swV/GRy0FGfHowIaw9Upsj1VFHwTTsjr/iV0salwVF5+M/RoC/KqKWokK4Wu/85CispGDveuPiZF+nxbYy0I7WaeENXqyNj2rhIet1pmBxMnWFS0Pj2shWbAss2AbVsXuPu83//6Szbp1NEEfBCOL1CouwgS7k74N6J0Zv4mx0DIbaLZoPjQVrDBH+yqsVrdwaopy8OPzyofAh3MWGEo
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 11:43:35.7449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c56a13-7e34-4a2b-938c-08d59bb3a293
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2999
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Fri, Apr 06, 2018 at 06:36:28AM -0500, Gustavo A. R. Silva wrote:
> Hi Vadim,
> 
> On 04/06/2018 06:14 AM, Vadim Lomovtsev wrote:
> > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > 
> > It is too expensive to pass u64 values via linked list, instead
> > allocate array for them by overall number of mac addresses from netdev.
> > 
> > This eventually removes multiple kmalloc() calls, aviod memory
> > fragmentation and allow to put single null check on kmalloc
> > return value in order to prevent a potential null pointer dereference.
> > 
> > Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> > Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> 
> It'd be nice if you add:
> 
> Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Ok, I could do that.

Just to explain .. I didn't do it yet since I get such report from
Dan Carpenter intially (https://www.spinics.net/lists/linux-kernel-janitors/msg40720.html)
and was working on it when found you patches, so then asking you to give
me some time to prepare and test update to driver.

So would it be acceptable put two tags 'Reported-by:' then ?

WBR,
Vadim

> 
> Thanks
> --
> Gustavo
> 
> > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > ---
> > Changes from v1 to v2:
> >   - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];
> > 
> > ---
> >   drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
> >   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
> >   2 files changed, 11 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> > index 5fc46c5a4f36..448d1fafc827 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nic.h
> > +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> > @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
> >   struct cavium_ptp;
> > -struct xcast_addr {
> > -	struct list_head list;
> > -	u64              addr;
> > -};
> > -
> >   struct xcast_addr_list {
> > -	struct list_head list;
> >   	int              count;
> > +	u64              mc[];
> >   };
> >   struct nicvf_work {
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > index 1e9a31fef729..a26d8bc92e01 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >   						  work.work);
> >   	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> >   	union nic_mbx mbx = {};
> > -	struct xcast_addr *xaddr, *next;
> > +	u8 idx = 0;
> >   	if (!vf_work)
> >   		return;
> > @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >   	/* check if we have any specific MACs to be added to PF DMAC filter */
> >   	if (vf_work->mc) {
> >   		/* now go through kernel list of MACs and add them one by one */
> > -		list_for_each_entry_safe(xaddr, next,
> > -					 &vf_work->mc->list, list) {
> > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> >   			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
> > -			mbx.xcast.data.mac = xaddr->addr;
> > +			mbx.xcast.data.mac = vf_work->mc->mc[idx];
> >   			nicvf_send_msg_to_pf(nic, &mbx);
> > -
> > -			/* after receiving ACK from PF release memory */
> > -			list_del(&xaddr->list);
> > -			kfree(xaddr);
> > -			vf_work->mc->count--;
> >   		}
> >   		kfree(vf_work->mc);
> >   	}
> > @@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
> >   			mode |= BGX_XCAST_MCAST_FILTER;
> >   			/* here we need to copy mc addrs */
> >   			if (netdev_mc_count(netdev)) {
> > -				struct xcast_addr *xaddr;
> > -
> > -				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> > -				INIT_LIST_HEAD(&mc_list->list);
> > +				mc_list = kmalloc(sizeof(*mc_list) +
> > +						  sizeof(u64) * netdev_mc_count(netdev),
> > +						  GFP_ATOMIC);
> > +				if (unlikely(!mc_list))
> > +					return;
> > +				mc_list->count = 0;
> >   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
> > -					xaddr = kmalloc(sizeof(*xaddr),
> > -							GFP_ATOMIC);
> > -					xaddr->addr =
> > +					mc_list->mc[mc_list->count] =
> >   						ether_addr_to_u64(ha->addr);
> > -					list_add_tail(&xaddr->list,
> > -						      &mc_list->list);
> >   					mc_list->count++;
> >   				}
> >   			}
> > 
