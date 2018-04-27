Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbeD0HXs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:23:48 -0400
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:14193
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757367AbeD0HXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:23:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 27 Apr 2018 15:23:17 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180427152317.11ef32fb@xhacker.debian>
In-Reply-To: <7b63b6f5-d93c-f2c8-c448-b81a8323c305@nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <20180419121801.GC17888@lunn.ch>
        <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
        <20180426141508.6660a633@xhacker.debian>
        <be2addb5-b3fd-13cb-ad33-f0527931a0d2@nvidia.com>
        <20180426155619.2c5d87d1@xhacker.debian>
        <20180426124007.GC13467@lunn.ch>
        <7b63b6f5-d93c-f2c8-c448-b81a8323c305@nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::18) To CY4PR03MB2630.namprd03.prod.outlook.com
 (2603:10b6:903:75::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2630;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;3:kCVxdftkw02vcC7hKagap7b+7VqTPFU6gubrDJoa+qSto236NEEST0s6GGgAzXdkGZq2wxXMQ0+EbTXZ1IdAooPvp/TcqckxEU6P7tP6gEmv+B35ybOQjwT/BNogBhhEb0/3M8XzIV4c+FGaJ5DismvJWM6k5bHdnrUJ4aEwey1BOcEIM7WpBxxMz9UudfPv+P3AVib3mW5NFWFlt5V6u2pxkgHX8wvpx6gPpcBm1Q+d5ib/Xx9Etx4s4DjIxGai;25:O7P0F6F2qXX1ljmfLXln3FYIGc7ratel7etoPIMyX/0DGBG9q27Zgyp4m0WUFIPaJAlw40j5kcSTpTTAha9AR3yP/w6RlUFrY4RtHgAjEn2r5oo/WdM7cqp0u93y/nsOUSt0hHXmerEu7oP6ruFui4Z5VsFQJBDyFzdcj3PtgOCW++kMfU82YfaGYOd+r9JcaVS1ij3U+YVaMVF5hleJDJ+zbD1qMojaBoBBapktB3Ws9NFLs9ows1edEha901QPPtHQdkh1B6ebtoW2zqJa7G8q9RsqAjR7VrgnqkW15CK1pLC/qO3+Wo1XkhZNp92hSmkq8E0Zvsn5dQJd9NWgew==;31:Y6Dp+brHcuMAf7Wxo/saA6vNiYg1CTGiqcGLJKx7sTnYRuyDH8Nopu0qMXTcTigQJ/KKnhsHmxJLENCdUt46FHywaQ9sg3PBkJ0ufAf1tYe4TFep4Hjr++z8NJKSykQ0igqNSd+OAuaqHJAGi4r/fchVbNpIbfO72dNADZvcvAzEa6MVNTI46/pQxflPKAHUpAXBxq8ZEtDsGUD9IndTzrMTxhvBKYUvxM8DagY8zaM=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2630:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;20:/xSPznSvMl3TFNA9IGe8Tgvd6GMwrQb00KVelKI2xc+z4EAbovi0/kxXTHvyOxUV6McPDSSz7OFXfpjMXxkCncIqGSx0jAIy6kxy/M5cWk0MO3h14n/2nAWtqCEHikbfEFXeBZZ5MOyM3fmNdMtTWONqQgYerbPnw71z0oYMZFLttmifdmC1AfeRlHF4lQOMl+wM0iHCC/n1/5g1APGvmYF3zdGCrBzUDM+6PNq7bDaKoIioQ02cjmYfzTV/xoNyGgYV1RErsZsbUBTIRdjRSmJXNemt4LHBDweSCR8gvr1X7pIhYfFYnsxxJ6YZxjXbBqiLyKWiwA4nu+lDRe9ninoicU4cO+pWQ2gFei6mGLdwGQwUI50XN/weaB/GGNu9dX9yUGtK1ctjHSEuHTVgZ/4pIn6l6du+IVc9tziHXWsEXc0U9K7phw2JE00yVCKWM+qmmAB/LxXIqBp4dvqSDySNWsouENhO1MaObpBLcxmrp2cemepw1xPfNDqQS/zo;4:BIFtTgkoWqsVxTUNrrTMUpg1bLKfb88fb9SToEy63JCYvsRRPKGmtiBoLiMcnGZazF5bv6Syr5qyM9G7Jbgobtgf8oQV5MXAJc+n9FimceGVsxgQ49wKbRzFm7dv3nD7w9WXL1aiF+EqimS2uXs+qch5c6jyrTl8lPJiB9zZK0a0DpsjIx835x7NgY0YbtxRVThEnVMwpMejuqAtlsur3cqHqGwJ2qXF/VzSVhvwq9mu+HE5HcZ8HjRr12zp2pwGpU+1a2jASkzOBPOw+ApV0Q==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2630E4F64022EA4D87B74DA2ED8D0@CY4PR03MB2630.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501410)(52105095)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR03MB2630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2630;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(39380400002)(376002)(199004)(189003)(86362001)(54906003)(8936002)(16526019)(229853002)(6116002)(3846002)(186003)(6246003)(23726003)(1076002)(316002)(81166006)(81156014)(230700001)(50466002)(50226002)(93886005)(106356001)(478600001)(4326008)(5660300001)(8676002)(26005)(105586002)(6666003)(6916009)(2906002)(305945005)(446003)(25786009)(7736002)(66066001)(47776003)(956004)(476003)(53936002)(9686003)(55016002)(486006)(7696005)(76176011)(39060400002)(59450400001)(72206003)(53546011)(11346002)(6506007)(52116002)(97736004)(107886003)(33896004)(68736007)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2630;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2630;23:qZJYsNAHJ8VXmEIl6VWFnRpjs8NlngoYfQYtWlCAx?=
 =?us-ascii?Q?+rkJXzlS07EigUykX6AVq83v3M4NUiyh0mzCu6V1LgAkQszarl3nkht8DAog?=
 =?us-ascii?Q?FcsHHWy1FSkTkbXgk1FKiEYfIFe0N7/hY/8Dc0FsakzU2eabQJi+qwx1AEtB?=
 =?us-ascii?Q?/KgZZJawNIjBQ1Jhw8BnzRP0W+MzT4i4mcL8D8QKxVWkXzJ4/XQLAToepeK9?=
 =?us-ascii?Q?VRJ18PlrNXaX5zLgGlEMtJgjW802pKlKkgSfY5z56uZVdn3/5Klr9S/YsYNz?=
 =?us-ascii?Q?P93+zT+t1Xp3z/k4ThmcRnoOBdqR3W8PbtY2sKUx0l5E4NORuvsz98Q8Va8y?=
 =?us-ascii?Q?R7meB3nMSWDBtWbFJSUq6xF19cZQngh+SH5Ti9z//5Vwa8ZATfqcaYBVKBak?=
 =?us-ascii?Q?WQJ3OsJHPDtTSgUrNED/aHd04jgptzuv4tl/xMWF5qCqt1gQ/Kk7p6/CvEtH?=
 =?us-ascii?Q?itGxVZXfedxcYdZCOkVHUhf+MADWw/5E1YUhJXuVhqYhgKpQyyjhhRTRTWB9?=
 =?us-ascii?Q?12y+vSBv3mIrjkbgYRzkIfWQkTmMPw2v/fKPBpx8kYq9owpWs70ywutJ9nj9?=
 =?us-ascii?Q?rfg5XFodv9JPhekVmMlTUsei41+77YtfaW+K0Ueu+lfLrqbYhYCv4Yl4snkM?=
 =?us-ascii?Q?ieFdp1ci09ED3pgjiPbOp/ezXANd5FmpFTQ1/qdDDw5Y0rnXMFJa/DGL3EGs?=
 =?us-ascii?Q?EiNWnPSa2+uAqvlFdtB+GkMFxXafjdcP+sAmrx8j/EsTzvjPp9UwTRZk9BK6?=
 =?us-ascii?Q?M+8esi82U63AaaViqJ1fkupAk+wzfTgXR4eR8+nVNzWmFmWUH/zO7UzSyTJI?=
 =?us-ascii?Q?hlwJHt53imIEqui8kXZakzbH0ZbQtaQnhlFp3Wj0oOlxhLghVpT3DuN+IHt3?=
 =?us-ascii?Q?UjAXC7H/G8zHDIoFjGitBauj+IVl8YkBjLXOxLuUdlZGH9z0sdazfVU8NkJ1?=
 =?us-ascii?Q?BdnZAdEOS8nJF4Z+cOFDK6txkUz/762Tn09yalpCNM0f3h1xMgvzHeICcEvD?=
 =?us-ascii?Q?F03TnhdQ0pn+WuZnAYKYS35+ecu3W/v9w4S0KOhA0VE1G9yxuCdTmgTouYEn?=
 =?us-ascii?Q?6521Wq7kvpvoLO/5WpyC6lxVH0uv9NHOagx4HJz8SvkWzDkgGTePirVThyT2?=
 =?us-ascii?Q?DpZB996Ow5HKDf78e6b44aobRlUgJfwWEvcFF7D461V/s2QVnpPPnhs3PE+Z?=
 =?us-ascii?Q?p2s/CWuCc14mxNHbrEuFgjFqKLLob541EL4mnwnAsFD1NenVVrtkAPif2VhY?=
 =?us-ascii?Q?ziW80F8+5VYTTc8SbfPlQ2EWSgHNv8/KvwSTNvKESPiiuFbCS9dVZFMD8P7A?=
 =?us-ascii?Q?Hbo6bHMJuswhG0ne7j2i+Olw7xF5FJzBp9B/JwHGdcZTRCEyFDxVYQgKUVWc?=
 =?us-ascii?Q?n8ZHzD/Tuq3AEUAis+I2BB/tk1CfHFN2cjCHEaCZuV1sfjt?=
X-Microsoft-Antispam-Message-Info: HOAjiI6JaLWzbXvuKyuVqtgJ1ZuaIQSbGBZcoK2lpAJXf+67Rq1AtdsFvjL7qBpdweVv93tobQZ9Wm0qKuLkYdpVWI6Ct8PSZKqSQNfEzrDgJynsfNBzVERVZaIH9Ahs17gV3sGo8158RhGaHXQE6dPKIfafIr2LJgWObwM7XdXESFheWYMMHyF6VUnJHbL9
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;6:sZKn5zAtSUIW04PG1+6m46GipVlwr1TVHcMAmtok0jr0A20/2wXJhIgvYxAPd4DeH8DJmHp7voRAQFMjR0DHqytl68YhLi0bZXsB8Nn5nchb1ppqTQlF7XK5na8+dQ0CXUvr+WXP01MAcEw7A+k4gvpMQ46PftULCyMX7QjpxpC5rtc5q+ISzNiK5jxoxtFPebjSzvJeB2l33RT6RY3MJVx+y0bn6PJ+XzfiV3bHfegZAx9pmIfq0AbEbytttRTA6aUDcPs1leCNiZLVW0o2ILQPoVbErxP7Wro4a8Y8jo2A1o/L8hsg98zP6Y+QhPbbfPwnMvPTxn3A3eCc7pDtuv3xOMjk+jvjH45si7OpJ7IxN3K8VUWuEA8Dr/pUvf3d9UkOARaimyfJwkpeGYw9CgGKo+fj9QqEJfaVwa4cEWLE0sNYFs0KMAVlxWkUpH4GTmvBfOehHYI+DJfrOu9w+Q==;5:lzGoBEfxMDJ6V/aMJm9r0k2hKr6SamOkKOF/j+zsEgmA8PRWPpB9fywwyBZA3ce98pr2XHaqvztyXbHE7KZV8YzSKboZvodqMESCHrBgvCLyu/2EEvnF/pzdDzYN93zfa1ILV9PmAzuSEkizSKb16Mgh52UHQaqH0MWTXs78WFI=;24:CKP3Ha0ui28weTF1ldrYYHS4vVOuU2dbhl89HwUB+XsXbDVsAQVx3BAHlPHptd9M9iVwgwqk7VPZusAMa3+NzHMj+6C4Z4acNgQC5jav+Zw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;7:pCBVUhacXvJRn5CVSoOY+75ENQaXf0MCjS3hL70RB3mL3LL/itLKA0xAMQYrKR8/FN7+Vrxcc9z28MkW/l6gD+UII6hOSK6Vk7gzun2PnabrB/tIk3Jr3i4lxxgCDbF8hFQnCBmWW3NT9nsI70i8ihpzFtBymRnqwftlY5Udybm7sECF6ESdQcIC+6fsn9m2hmGcyaMK7Kfnm4xvY+GGTUzGVAdU7czKNJC8RW4eGqTUgv8Ox3npMueKeUVjyLN1
X-MS-Office365-Filtering-Correlation-Id: b55d1fa8-3b77-453e-c117-08d5ac0fcee8
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:23:42.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55d1fa8-3b77-453e-c117-08d5ac0fcee8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 09:22:34 +0530 Bhadram Varka wrote:

> Hi Andrew/Jisheng,
> 
> On 4/26/2018 6:10 PM, Andrew Lunn wrote:
> >> hmm, so you want a "stick" WOL feature, I dunno whether Linux kernel
> >> requires WOL should be "stick".  
> > I see two different cases:
> >
> > Suspend/resume: The WoL state in the kernel is probably kept across
> > such a cycle. If so, you would expect another suspend/resume to also
> > work, without needs to reconfigure it.  
> Trying this scenario (suspend/resume) from my side. In this case WoL 
> should be enabled in the HW. For Marvell PHY to generate WoL interrupt 
> we need to clear WoL status.
> Above mentioned change required to make this happen. Please share your 
> thoughts on this.

I'm fine with that patch. Maybe you could send out a patch?

Thanks
