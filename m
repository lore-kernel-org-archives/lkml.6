Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbeC1OmR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:42:17 -0400
Received: from sesbmg22.ericsson.net ([193.180.251.48]:48778 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeC1Ol5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:41:57 -0400
X-AuditID: c1b4fb30-44bff7000000197d-02-5abba9b2f08b
From: Jon Maloy <jon.maloy@ericsson.com>
To: Arnd Bergmann <arnd@arndb.de>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
CC: Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tipc: avoid possible string overflow
Thread-Topic: [PATCH] tipc: avoid possible string overflow
Thread-Index: AQHTxp2NVpY4c8ilWEu176m6nvN3U6Pls/pw
Date: Wed, 28 Mar 2018 14:41:50 +0000
Message-ID: <BN6PR15MB1553BD0EDB723303EA5FAC6E9AA30@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <20180328140302.2594031-1-arnd@arndb.de>
In-Reply-To: <20180328140302.2594031-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-originating-ip: [192.75.88.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1905;7:sr9SlV2HX7gNoNacOHo+WMNR65oanSARnNoONUfRJbnOSIn15UI7UHLtIoJsUkUNuZ2ikUNso3E8CdOVlSIvka7F9w+m5+L7aXHlPtn0qAVl4rkd54ordeMgLLhWtub1Lou5hoRUfNNDE0kk25gcvSSgmpIbJxeGnnnf4PU4f91BD66HmvpTaSftnx2MwsNgnujUpAVCcqfBpx6FmItxObPFsjcagjCVWZx0KorUKpUPV7d01z/UsPsjgNU+yWy2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 99078834-373b-4d30-46b0-08d594ba0ad0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1905;
x-ms-traffictypediagnostic: BN6PR15MB1905:
x-microsoft-antispam-prvs: <BN6PR15MB1905D7156A37E006F1D734EA9AA30@BN6PR15MB1905.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(9452136761055)(42262312472803)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR15MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1905;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(39380400002)(346002)(13464003)(199004)(189003)(25786009)(14454004)(110136005)(2900100001)(229853002)(54906003)(316002)(478600001)(2906002)(33656002)(8936002)(8676002)(55016002)(66066001)(53936002)(9686003)(81166006)(81156014)(6436002)(5660300001)(97736004)(105586002)(4326008)(7736002)(74316002)(6246003)(3280700002)(3660700001)(7696005)(77096007)(26005)(186003)(305945005)(6506007)(59450400001)(53546011)(76176011)(486005)(102836004)(486005)(476003)(11346002)(106356001)(575784001)(86362001)(3846002)(446003)(68736007)(99286004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1905;H:BN6PR15MB1553.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ncWHt8zlLDJyyIYSxvy3jj7Dm74t//W/xh8RdKxcKed9B8eamrBwMk5zrIQQgBhEZxcnNKPyiGHofy1PGOHNNbo5xHPT4tDh0TuB5nVgZ3s5IBKoqqQu9c7OzkG2f84C+DRSsu9ZWfWBy3Y5/7C5ZwO+0j3J7EaNclI9g8HqmbODWG0KzKqhglT+KP+J/Pz9qhMlwLYoienEc1KuWrTbiOcIe5ih9cBDnY1G7wC5B79AoRxdPnZ6F4wCL8txNhlaGv6r6kzaQ/s5ljJWNIs5vd8xX69G8A0sl295Q+QIqvmWSIhMmaOUgMt18/pTYO3d7dkOcG/W7392nShykWpftA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99078834-373b-4d30-46b0-08d594ba0ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 14:41:50.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1905
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/Z5XgZvS6dD1pJi2A5r0Nrht2oYB9ShKC8RDn1oDbdxqaW
        CaFUECpW3sJlOUuFiWjqLHOBTebKC4mXkIwmoeKt0jQyEiPPzoK+/Z7n/3/e58JLkcKnXD8q
        U51D69TKLDHPnVMT/+JQcIfJkhjWvxEg3yq38+W1I7c48vGeWp7cbhTJzSNX5DOTk+QJnmLz
        dzlSmE0fCIXFuE4o1jv2KtrMXUQcN9E9Oo3OysyjdaHHkt0zXnbM8bUO0bUe+zAqRE3CYuRG
        AY6A5Yd2VIzcKSG2ISibqSbYwIxgsOynS9lAYHyyxGdKhLiRgNWbyYzAwWsEGOZK+KyrgoCN
        6XeuwI6gq8zkLOFhCSxW30EMe2MNjBU3OU0kvkvAwI96khF24SiYrvy8LVDbpiPQ/1rGogw2
        F2IYBwcfgEeOfh7DAnwR7IZRHjtRBHRN1Dmfd8ORMF8x5GyLsAg2BlsIhknsC1OzdQS7NIaG
        VyMkyz6wOPOHy7RCOAGG5hLY9D6wdj/jsrwHxupKnJcAbCagsLPdVRsMq1VVLo4B6/AAlzW9
        RWD7YnYJgdA+YSOZBoBV8KbxKosFUDbseQ+FG/6bjuUgMFrWeCxLoal+mTQ4N/aCgZpZjhFx
        mpGPntanZKfLZCG0LjNVr9eoQ9R0Tgfa/jpW82ZYN1qcP9mHMIXEnoLi+5ZEIVeZp8/P7kNA
        kWJvwYpkOyVIU+Zfp3Way7rcLFrfh/wpjthXII/tTBTidGUOraJpLa37pxKUm18hurAk0B48
        m9Ks0kxHVgo+fi04nl3KUy84OkW/4pYLRt9XGnbmSk2t1UdbZb3npeagpBVS4RN7w6YJ8OrN
        EAU9l15qSw0xLawItXSvpEGyI3kxqXTKY35/KDfDQ9lSVKTKU3me2Tr1beTxp3OOgsNtAdbx
        6N234+cfnC4XRX33l4o5+gxleCCp0yv/ApVpKZo2AwAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SEgNrF021777



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, March 28, 2018 10:02
> To: Jon Maloy <jon.maloy@ericsson.com>; Ying Xue
> <ying.xue@windriver.com>; David S. Miller <davem@davemloft.net>
> Cc: Arnd Bergmann <arnd@arndb.de>; Parthasarathy Bhuvaragan
> <parthasarathy.bhuvaragan@ericsson.com>; netdev@vger.kernel.org; tipc-
> discussion@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: [PATCH] tipc: avoid possible string overflow
> 
> gcc points out that the combined length of the fixed-length inputs to
> l->name is larger than the destination buffer size:
> 
> net/tipc/link.c: In function 'tipc_link_create':
> net/tipc/link.c:465:26: error: '%s' directive writing up to 32 bytes into a region
> of size between 26 and 58 [-Werror=format-overflow=]
>   sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
>                           ^~                              ~~~~~~~~
> net/tipc/link.c:465:2: note: 'sprintf' output 11 or more bytes (assuming 75)
> into a destination of size 60
>   sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
> 
> Using snprintf() ensures that the destination is still a nul-terminated string in
> all cases. It's still theoretically possible that the string gets trunctated though,
> so this patch should be carefully reviewed to ensure that either truncation is
> impossible in practice, or that we're ok with the truncation.

Theoretically, maximum bearer name is MAX_BEARER_NAME - 3  = 29  (because if_name is only the part after the ":"  in a bearer name, and is zero-terminated.
The lines just above in the code reveals that the maximum length of self_str and peer_str is 16.
This taken together means that the theoretically max length of a link name becomes:
16  + 1 + 29 + 1 + 16 + 1 + 29 = 93.  Since we also need room for a terminating zero, we need to extend the tipc_link::name array to 96 bytes.

I'll fix that.

Thank you to for reporting this.
///jon

> 
> Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
> values")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/tipc/link.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tipc/link.c b/net/tipc/link.c index 1289b4ba404f..c195ba036035
> 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -462,7 +462,8 @@ bool tipc_link_create(struct net *net, char *if_name,
> int bearer_id,
>  			sprintf(peer_str, "%x", peer);
>  	}
>  	/* Peer i/f name will be completed by reset/activate message */
> -	sprintf(l->name, "%s:%s-%s:unknown", self_str, if_name, peer_str);
> +	snprintf(l->name, sizeof(l->name), "%s:%s-%s:unknown",
> +		 self_str, if_name, peer_str);
> 
>  	strcpy(l->if_name, if_name);
>  	l->addr = peer;
> --
> 2.9.0
