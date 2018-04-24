Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeDXRSp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:18:45 -0400
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:7296
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbeDXRSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:18:42 -0400
Date: Tue, 24 Apr 2018 10:18:37 -0700
From: Felix Manlunas <felix.manlunas@cavium.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] liquidio: fix liquidio_xmit()'s return type
Message-ID: <20180424171837.GB7020@felix-thinkpad.cavium.com>
References: <20180424131637.3707-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131637.3707-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To SN6PR07MB4223.namprd07.prod.outlook.com
 (2603:10b6:805:62::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4223;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4223;3:6x2W+7ZelNkXU6v1KnHLeOwr1PENVl/RLPArS8KvWT60PfH+KX8HDQaMs7eebZ8784HCIvvaX35zCiCh7HQDzSLGanc/VCMtkkElt97RtNvGl636YAa8ZsfJpE0IFpRQpiYM966uXn0+A4/p/oCtAVk7E/xBivWqjccRTutlWCxPAdwf7/QtQDx4GrPZ43IyV0c+itrxpC9qPcWei85sTNcPmlAArZF7hhCz9HcrMwRlfUL5ayq6R508YPSnekMe;25:XoNcUZV+Y0VUbVPwmwSlKOf+62qbY/CsHu58JPGqy9aZuE+Ix+Vm6QxOL3IsG42UA5vknP5UblM8sGNWRCGG0HRgGOUT3JNTgEdxdy11h0Bxrc8zh9T3GDgyB+eCBHeDh1VvL9nKeJmiEtucCEm7d6m37Fq3JAzVxJxvFULMfz45RD2J9XyJaqF+DsK8jpuZyeOy+Stf4TFWtcZ4R6V8cG2W8Fox+Gpfq4EbdkVvSF8D//I3PbQ9K9FfGh1Fb+GgpI9+9fD+OuleToI/Irdxzbwvccx2T9UgvT3mnICIMsLkdt3zsxm7Xppps9xkvxfwPrGxaNyOzWj81kQ/E3XEPQ==;31:KlEaAdgOdDbRyHmRL2wuzmsMlF5msALPfCee9bV3uVE1aAqCBXLT2QeSRqP950u/DjPacdj/q/0eadXIVYtn2u2fjwv4mIjFZb5VwHRNQ6Njpw7FFkEeHVMQhtPBzAdeQb9G/jbvECU7bhCxxtb5wCAhB55SQcfFljtsxW3IO4Qh6q6JpkDWOWpDLLB7+Vwk6qYhKl/FhOd+lAEyT/a1oZhXYdCXtGVXN4ixPpp7TcY=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4223:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Manlunas@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4223;20:fMQcHtU/J4IVCmXwKQ6nTMG5l7l6tbzTOknzNLWpCJIdGQORQNMauidcj1erZT5JTTPIewIBbR90GNQ7nWP1EsD/X2JiTGPYxG59Jh8pTjadMZAk+nkanwrgxxzA/aZB5C8iqgdAjuZjpwRYrW4rDUK4P+vxx78ZWMoqtCpC9kgXWC3z1t0V/CWmy1tF6+3g/n60y6WO5TTOFNt2mTvjdrDTlO9U6wdJYr7F5Dtak919VPn4DKSuY3H3RfXdkLRPJjze62l3pXa7WIPc0uOJDKS5cjSpLhyRdihCsfrgDHLAB3LciwceCUOoXeZpZ09EQYw6G4tehYQe14gZhb5EayNASn3wQ4M5Go/hcgV6SFVTRHIQl+k1GaKPTXk+ymzyeEdfca77qFqYzHlDoO0S3/AtDVzG2N2f0psSPo08QJtI+cvEa343DrsS4bKkRlYaYW/etxYvezFY1Z4AvxGjZvUKJ1ZJW89CT9YmIUwB4s5DAROFLi85KVrQ8mIniLou;4:mMb9C3Xz0GV3q1j7p3/AQYmG11nZhl6nntYeZvg8i11fWBxRG7iLtrzUYs/nfaEdWn8aWn7D5PRXGQ3Rq67Gk8foQUnNee2GeaxEfhkD5l9zd5hdQc4P+v028q0Nts7oyjr/68Y6h7LB5HoshWuRKQnFYWa7rSeluuy7JCkVxrTjcGjJhYyOJU/B9z6hWgIjZZi239H/grK4S6+hZYKE3UcJQ6uVqgc7YWqMwx471FTIVaq0HJvfbAUncuz58ElgU9ZlefUAdTZeygCzDMNugfJ5+mhKAeAL24WY7C3SD5a++lcDs7VQwJK8ny7s6EFT
X-Microsoft-Antispam-PRVS: <SN6PR07MB4223BA969D1704FBC93A7ADBE7880@SN6PR07MB4223.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4223;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4223;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(39860400002)(376002)(396003)(366004)(199004)(189003)(6246003)(3846002)(6116002)(4326008)(47776003)(66066001)(33656002)(39060400002)(186003)(2906002)(23726003)(16586007)(8936002)(1076002)(81166006)(81156014)(8676002)(58126008)(25786009)(54906003)(53936002)(106356001)(50466002)(16526019)(86362001)(6496006)(76176011)(105586002)(486006)(6916009)(229853002)(52116002)(76506005)(6486002)(68736007)(72206003)(956004)(476003)(478600001)(44832011)(97736004)(7736002)(5660300001)(11346002)(305945005)(26005)(386003)(316002)(446003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4223;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4223;23:trQHvCKRNRkC0GlKAb7qM5WQBaMMIojms8LwyA/kH?=
 =?us-ascii?Q?WadsYWR20XL69L5H8ACHyqm0xyx8r335RnlS90mi8GU24HJn3TQg5mZT69Ou?=
 =?us-ascii?Q?8hS6M6N0QoY9M+FvAnSsmC56GVjn+1MZpISI2hOdjRXp1wP4gYAhS0BzsszZ?=
 =?us-ascii?Q?mt/7Iy/X3rxUn+O3UnejA0kgnYiGWV40AcdXDpSYXDjf1l7cIl6aGWrxYf7B?=
 =?us-ascii?Q?+XQ2kGEoZy93PdcXT59L5tmZzUARyeiivvXKkGgsmLVZKWJ2WLOIimhwlroq?=
 =?us-ascii?Q?bfBO8sPy7HcVfNX8y5T0X6jxCq8GhbsO6nM9JSpKnLoSPRiVWvmgrF0xBohR?=
 =?us-ascii?Q?xR1mZOp9/7BlOMZ6D5lvO05FpZffC0Y/u/XAEJu1QuCLOciLaexxEc7+nBNe?=
 =?us-ascii?Q?spOn8Lpk3Lx/Uq6icoM9ktL3RW2e4B/EwtLjckCJJNGpq1xdnvfypThb6/jz?=
 =?us-ascii?Q?dPwgbJT5VHTEer6ZoYJ58y23yj1zsKssIV/errC1ndCTgPtvdkgggk9DJaxw?=
 =?us-ascii?Q?a+DMyn+W203uk+0+JpWKTaY4CN5DFufBY9rVly5wHgjnxFCVGcaBOeHS/6h7?=
 =?us-ascii?Q?zFtgwvkPnPBH8QNZY+HcZKmU0Bo2/xj8e6mAe2lPQ2jbaPdV76LIMCRXxamX?=
 =?us-ascii?Q?ebeRFtXT+XjR+odFndEE5Asz0o+YaFoEuKRP+yJXQTV8vkqNKQznoZR+Gnhc?=
 =?us-ascii?Q?os41EtKi4ye+GnhQDTyKSNMY7hVAAbOlD6/15bs9KeEXYwWosdf/bkOA2Sg5?=
 =?us-ascii?Q?wH/h3eoqaa24Xx9oZwNqB6z4i0oUCzbY8Upkuzjz2Gtkl4QlsriF5jzU0/R/?=
 =?us-ascii?Q?r58WYfg4oRPFTkRcLS9Mz1tUn5DnjQsW/W+cUF4FI7mO+Lz/AMXlZh2pfbQk?=
 =?us-ascii?Q?CUGvXcn8AlEMAOnNWJNlO/qgldP/1lRgB6+JEd4EnQE7zdh9V7A23wzp/+pl?=
 =?us-ascii?Q?n87QrdWALq45h0yEyoeAYDc4xcG4LKphpDQCVJZWRxmXAO/UQT8q1nrZs+pJ?=
 =?us-ascii?Q?6mkUfaE6NK02MEFvExkN10eIoGWotNG3ZJkk3RrkmekN5J0N7i4T6G+hitjJ?=
 =?us-ascii?Q?Ax54GlH2DhYyfnVXK5WAqgNY4RB/JcV31Yfxuvg3sxDfrypk30aF9+lByJKP?=
 =?us-ascii?Q?MDUJIfPKm6BFyG0m91nfjSfNEny+fvqekH29at14Sm4UsQmhnP7OoNk6YwqM?=
 =?us-ascii?Q?b6NUpvt6lfIXHrerS5oaPyai3b4mHtINoCAD/aogIqrfnRoxYXA7g6AGeUGz?=
 =?us-ascii?Q?yy0bVezC7fEnBoxVgJ36MRaP7ArCx9UV70N0CEvIdGpPVDLQ8rhl0pSP56KL?=
 =?us-ascii?Q?Xca4Cb1hrnWxpnL8sbsYqc=3D?=
X-Microsoft-Antispam-Message-Info: Swy22I1YX8ZI98sDGZjnHx3ihXscHcApJpXEzqNlg3+j62tzFRxPBL84jbmKBBeVS4KNibd4XjB/6AG1hGKtCMOxfiO19M2fesbXNdTjxSM02ILcjogXYXGdmteb5t9lyb8IFhQ0Rf8oOHyNVWAoZ5xctd9kYwk8/54tWvhZL7imSjm80mMFoWK2dhxdg02A
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4223;6:BLuGTT88qqxQphQ7Jwrmpuz7rm0i+bkcr3wdlVIEvHgk8UIPTBIhhl/0/Zd0uI+c9IY8cHMCj98L85di3HI2QIwXQQe4lwemMZcilo1BDiFwIrZAx18LmtzQZOdcI7fzwF9IKoKsVHY+wE7tLF3vmx/MANBUf/HLTQTDMVku0n0KMqLVpsAOCpJhHtpAn/zo8i8MlSXjPPh/lNWM6Vb2hpMTLAMuRSm4t1CwvfQEdnIdomxGZydIVfD/d4IxAacPHgFP5Y8xIyHoeeRLCxB19piJ5fyn1W2pPascpQmquT62ycQAQUrooZzBy1zHsIpWsTrNHmQIneWfhcbKEbKX5s20W6y3oVCjD1YcOnexgKiAhWikuuDUgUZ6I6EEsjJ4aRqkdLuBHKAKVnCmCjGJSVpLSujUIF4MuTpEM7961LPf5rLPRQOSwdEn2HYhc74wXfTE0g+tdYFNhapSq4zRzg==;5:6YWWvxk8HRZ+/BA+YPjFSB5qe06fTV9j6Zti7NC5psjH6AHEFRvMef1K+l9V5TaZOFwBPB1ovEGsr/lcYXHZ09Y90MUIHFAL+CH/tMIipPPtV3x6KylzIRxBc7/yt7eS25+DPT0dPW6CoIR+aj78iYtGjpCE+bEPumGbuXwkzAE=;24:ZAHthwel8lIkTjt0hcZVqln2U3J081iW0UjNxyuL9q1gG9gdy07OAsEx+KcFc3fhJAmIkEK0tJOyfPp8no8jq9VlaOWx9ZP5cH2WcUcoxHI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4223;7:nFNi+99dFYPkOkuNWs6FyRqFl/mjNQjrV0RfjxRMbfewZLzCOcueitePKqUYKnRnXS+TK9+9IfDqI1asyIiCfdaj1S8phvdGzkLgtGTffWCDtj8+Q+GoU+8JuZiv9S3NSg2dFP1aJlPQEnWFNhdBj3UL6SPi2zQts2Wf1FKIA5mYhHuP1j8aoRq4KVCS8Xv0LgEYUoUNzboYSoWcwaCIte15QspMli0A/AKaV6LRRFuRKnXvvUSI+WTSUx58iv7k
X-MS-Office365-Filtering-Correlation-Id: 46ecef98-30b6-469b-7777-08d5aa076c53
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 17:18:39.9195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ecef98-30b6-469b-7777-08d5aa076c53
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:16:37PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementations in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c    | 2 +-
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 603a144d3..6d6f16815 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -2491,7 +2491,7 @@ static inline int send_nic_timestamp_pkt(struct octeon_device *oct,
>   * @returns whether the packet was transmitted to the device okay or not
>   *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
>   */
> -static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
> +static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
>  {
>  	struct lio *lio;
>  	struct octnet_buf_free_info *finfo;
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> index f92dfa411..13ef46a85 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> @@ -1560,7 +1560,7 @@ static int send_nic_timestamp_pkt(struct octeon_device *oct,
>   * @returns whether the packet was transmitted to the device okay or not
>   *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
>   */
> -static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
> +static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
>  {
>  	struct octnet_buf_free_info *finfo;
>  	union octnic_cmd_setup cmdsetup;
> -- 
> 2.17.0
> 

Acked-by: Felix Manlunas <felix.manlunas@cavium.com>
