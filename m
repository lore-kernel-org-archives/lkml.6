Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeEPQFk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:05:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56184 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751928AbeEPQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:05:38 -0400
Date: Wed, 16 May 2018 17:04:19 +0100
From: Roman Gushchin <guro@fb.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: cgroup: memcontrol: add basic test for socket
 accounting
Message-ID: <20180516160243.GA31445@castle.DHCP.thefacebook.com>
References: <1526470089-27010-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180516140332.GA19754@castle.DHCP.thefacebook.com>
 <20180516144826.GB23563@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180516144826.GB23563@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:9bfa]
X-ClientProxiedBy: AM0PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:208:1::30) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:mPAb9HCApYy4I9e/VZETglXuLwCERT0y5e9zLC9QUWx7Umxz4aY1gzUYdubB41New/urdIvx+0261cl9V975lUBVcld9/qc4hdTUtOBhpIYl3Mha5v1UtvXO1dEeTOXGd726SfCb+vgfTzp5mBCeaUaLNqUnXJjmZcZALa16obJln53bgHkTFDBXhcoqOAEB1YwvwE5Tv2wgZA1knemMwS7Ls8LZuXoR1UhINp/J2qrYqw0YZz2l85giYQBRd1dX;25:vBtif6JhZ35J3vJiUIC2bIeYjDnWGeLxq5jrkvPzhgv7C5040bz3RmHRxRN5kNcSC2ljdnnGwDmakBvWKRnZHDXjKQuq7G5VpHjaz/gmp8b0AAuGN8TW/qvP/aGE4mLUf7nFdGbmslVd7B0LCB70EzWR5SPoBrSLsMTsMsRhnk1Vk0CCv0fPE/QB8HzIG1KUrq7mTHrt7TBvNKonlBWRxVJhOI+m5dcBoLwPVYJa0qnLwv2h7hRsaiLbpCHq6reuPFLBTSmjr51xH4091BAkNHYu2ByOVPIPL2v9kZmUXUimiRHiKewhGqoSVjXEhHQkVpN2QuE0dN/oy6vzpV2lnw==;31:EB7rtz+QIxfwaLVSbvib1/mQu7itROmuf1hNmBVukMTkUrQ0Wio/+Wz92vH6P82ttqNEeFIakg/wdoI/5PlLNdvQvik2OdJjZ9yd86OmA+pE602doLkC6nsOyk6Xozt/lorS9kU9aKhzssjtMyDNPVY5ZB0qJVRfr00fWovupw0KlUpUMlLr9fs5k1uekUpio/GzcK4elYXHqIZCzDmzBbaecAqF71ZDTyG1hVh5LuQ=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:8+rX58ckabLw5hPHsJSBEUo0kEyx1VmuWbag2dqA28s641WEiZWpl6GVn/EUHUHQHzuhrwLLalrAl+tW08ubry5JlzWXxBr9A02cBWiIL4BvZexpUy5i3gfxIsgW3w00m1THQKXwxZpgX31yXHESadLiKDEZg/VLGj5m/N2Gevm03kvJrZVW5CmnhoV0psO0YxLm9Sl0cVvk9OiHJSLJCAUHsOqKKhY3WKoplRYOYz2ig3b8wImsat3En5uSOzj6fs992ZWNjvUEi+uKycIMqvNQ/Qm90YrNAwEykYPTbjjgKZdqHS/xqlnbgrJzMv5M443a4QCWLgABNaAFlNdfxrQhQkS4VmXoaDo00bVUTALy+jlRqWaIiBxOJdm0b8UG6Qg+NwwVDJhFDJsQZH0Mj524oR1vmauziYFTO/xQpyZL85aUVyV4M+aFQSCLtNbyCng/NqF6xDt4CS+Mj6x2w3mM+c2ldvQIL4Zo8L4n0u+eRdOX8mAVQdF6xtOekVXq
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077A28F2B8B04DB8F8E4B2EBE920@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(265634631926514)(67672495146484)(104084551191319)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;4:l1+6p0V6E3JOGD4VCFGrIiy225pwu1BKXflnOMdeJB0pUjjJUyQuos12Nq14rz0XOh2LTjzU1yZXM73ZSNzYII06DVj5TdNWCnyAXSwkHiSxSXan8HlCPozrLjOOJ185YxBeYzt4R9X/i8FABrp/x/FWByqF6ZyJ8UjgN4kiCG9CyG24obSmy928k7IXFB4KYT6exccBLpy1HslvvA2DojSBNjTEmqTYB+dHBnaK9Px7Lr++L+f+XLSCIplRZIgn6RajmLSUQP3i3ti99mSh2x70szd6n2eFIDQopiVhwG/ublfQA/tRCD3Z1Gg5n191xZ8UZ6Zu++tPbnVul5yZnGZssstDOQa2OAYcVWXQjII/VNmA5URXR+GFUQ0PmAalsBaVgKx9kgBH3ZjHjWyqwRKw+Rz0jMl9pum2b1JUtVrNgFyOk9oj+MzRTYZPOZDrT84J7zBdzlppMfP40fIsKA==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(25786009)(16586007)(316002)(58126008)(97736004)(76176011)(478600001)(7736002)(50466002)(229853002)(186003)(16526019)(46003)(54906003)(68736007)(59450400001)(23726003)(6666003)(476003)(6916009)(1076002)(11346002)(52396003)(446003)(6506007)(386003)(486006)(9686003)(47776003)(53936002)(2906002)(305945005)(81156014)(4326008)(81166006)(33656002)(5660300001)(86362001)(55016002)(6246003)(7696005)(6116002)(8676002)(106356001)(8936002)(105586002)(52116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:Ed31QzqshpOwlM5PB7nalgVCJ5opntR06DnyE+vUQ?=
 =?us-ascii?Q?D7CQbvGtW+gtaXzxbdMo/9q9LIuDTEXhCiCpIlEERe01VElOnJTTjLw/P0SB?=
 =?us-ascii?Q?GqPRJ6jwJj0ig2PGTMs3WsDNbBcQ/b7SUoYfuVIzw0t3IclojcxLOx8BLoim?=
 =?us-ascii?Q?VDU6qF0UMW9gR7aZNVkOEJsWNkicqOA9485u4q2Lp4W5BizUpTLXUbQYLQbS?=
 =?us-ascii?Q?QwR/gRv93uddItRnEDu8OklwKJYW8Js3awxoef48qTjefri6toq3xf8+VV+l?=
 =?us-ascii?Q?myeDx379FCsnQPRgjfWN+VsG0ZRzZadevxE+lm51FS0OnyhHTzSFUyRm4Z1T?=
 =?us-ascii?Q?/Ie1/SfKps+fM9NGzXCx7j+nowzzkjz+bfACpBuTSXyuSV9TEidJyjKkzK9h?=
 =?us-ascii?Q?8kkdr9MiPLGCHJjeG6n7gyoJKRdyoTZOX/W6uh87oUjwSYX1rR1E1A56YYwa?=
 =?us-ascii?Q?VulC0pIT/nr6PbF/9qURQ03wkT6eX/a9NuPRN46iLDEONVddPrIAs0tC+JQV?=
 =?us-ascii?Q?Iln1lmBaOxBo6IQimm1GSFLcv9OYpsoayE3jx36LAY+WsxHSGy/TFiYJFgbU?=
 =?us-ascii?Q?ZpOpjMD1zoIYdG8cYT6wfW0tYzFYwFZ7DwdzU5Kn5iiKkDlXEBjlKLT45CH5?=
 =?us-ascii?Q?8uyqsxTgVNydZ0mL+m0rlsKTpy/y0RvtPtuRB6sxRdSEQ4Zr+TVmL0AluB1b?=
 =?us-ascii?Q?hhsqmQU7kPwgvLxpuNYxwl+u448g6Iw4083Puvsuz69aHIr8z9nYEP/kU+dN?=
 =?us-ascii?Q?8hgSY25LrvwScp0/VylyjKRHarcrSccNVCjVnBE9hoDMUz9VI4c/+Ae0qycC?=
 =?us-ascii?Q?uBefXvmfKGw7AKkdcv90NpCuPbpjj7RtFiSxX6U7da4qXqDGZ098lxxFBL1p?=
 =?us-ascii?Q?bCIEBI1eQpuioXOp7elUCP/kmMQ4KBf/CgH6tuEugyV3XjBhYR3CwmAaHNfz?=
 =?us-ascii?Q?Q+6w2N74G8ma8kF+fCZWFLVFmoZL8lnajJhdez+PuVHI6StHh1u+Zbet804u?=
 =?us-ascii?Q?sat0GJAPPYhX9pw/i0jRKtm1x6ffHN5oE5eS8xeNuyhqlvu8IroQpy0NuWi9?=
 =?us-ascii?Q?HPjcKxhyZCu2DpbRCn7x79Jyun59dMb5Kip+NFx4LjVxv3m/ru+smq/wNcEj?=
 =?us-ascii?Q?D5pAP2VzCSzcQYo3+dufg3ghNhzI6obL5qEbn7/TnumJBcgRl9BG1fs16VLQ?=
 =?us-ascii?Q?xt+pCRxChuCNxRAd2q7eBaYVA7MreVFxmoVGqNnPY2wWqVuBzIJCw3Hh79aw?=
 =?us-ascii?Q?GUNJFiJfrrv9gn7ok6hqrrxO9ujIas5kED/imBt?=
X-Microsoft-Antispam-Message-Info: mvkJkztV09JJqhvxdVXcBnmVOnUD47smfQQnAlWVlVdy9eY3l/MElssd+3+Ge7T/3kfLMFrYzs4kafjsWzCKS8CtK4RCJl64EJUPcb6pDPVo2jK0WZchLC4haR0i179tKUvgRoPMMj4YVoZWHM2PnR9SgBtLX7976RSaIXxCCGBhSqPW/48Nu+4fMqwUTSnz
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:/VfZ6PtZYNBFBEHykZDXNN9LXaEiYvoSl22+EzVANmxxE93JLcIG1z+2qtptgUTx1l2SJihSlee5dkAgOta3aO1+jM+rdKh8xj37xSw76DP8fzZ/qPg9cwfeLHR5GV7CI+M/lAhaPAWS5hGfDn7kEsop3A315MYc+/mZsCgMExEpQw45xbS9GfM8PUyGnQtOmoynxwC7rWsq1tBiSmlTW4x8ewQbwTjpY+KFJA04R0w2lCxFtWCZQ/BR0tD2Q+26MtD0JfPyTkjmNsDViUCqqDCrG1P5f0Oi+RrTUxENfPHQ4UH4r7MROuHJMkPT+IQ6NXSIkIwX9EzYSWYPLoNBfOBlwHCsMRaGvwSBIhQBdY0MHvafJ6UiQ7di9KebFfQS3zEZtB2v+OU00nDbE86yV7BFtlJIrJS3C6rqiur2+tFhQtfgD6+uzJ0NNGcqqsSJL25dsmLxitC+bQwkRyy4bA==;5:nzRckKTrmU6KBAa/linkbMA+0S//ifZKLRpG8efnQp3UuiJTEG3TSm+kYECOYRBm1hJEV8Ys0PETzssMQ8aZxfL022NUsAkXe/0yD/yh8/EMGFxVQTRh1gbV7lzY7E+qkQs3LTuhx8uZL6mnGL36t+C3iJ6DWn4fGGWYrVNmQNA=;24:16at2IN71PQfa8S0mLFWe+uDJwdu+YcxdqYW4qOUTuRmYeshRtOqR98SmO/YuD44ZE9u5vvouHYZrnaQ3WIzamH7y382XQbqjhBFkP/GuVQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:xwsP9gwdiRzZ8Eo5Pq6W4oDZEazg6X0szHsrMCRs6BFRI4yDishHGM7bYhH9mhIeQ+5+j6ceecSFUlH7FZuWm1+K4y8loM1uC54MeGc9YomRaxf+ZAwJyv+6l2XcFnL2qrMyHAAmlUl+2K7Z9Th5AbDBxIpNRtTH7rofLk+zhP7vsjNk5nQttE8zFQwcPvt5BZHloJt+8UyJDzmGZS/sAB3ek8d7oxIMFGMTzcaVd0zDoNq2Ljte9ADKiSV14StU;20:ovSidZVOOJuo8C/IYhGJfZ/luV4tDI7SLv5V0a8O2j0Il3VB9PORymwyU2VLwg8PwzWbNdHzPioFcHeF9q2VtokZ3tzo6l9mxnjBEGDvNTG7X48zkyDUsZnh47cWWCushs+k0AoWdHy8Bx8YfG6ao5TOKMTObKhZkex9tUXZIfo=
X-MS-Office365-Filtering-Correlation-Id: 2d7921ec-b499-4a8d-da6f-08d5bb46ccba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 16:05:08.7351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7921ec-b499-4a8d-da6f-08d5bb46ccba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 05:48:26PM +0300, Mike Rapoport wrote:
> On Wed, May 16, 2018 at 03:04:08PM +0100, Roman Gushchin wrote:
> > Hi Mike!
> > 
> > On Wed, May 16, 2018 at 02:28:09PM +0300, Mike Rapoport wrote:
> > > The test verifies that with active TCP traffic memory.current and
> > > memory.stat.sock have similar values.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > ---
> > >  tools/testing/selftests/cgroup/test_memcontrol.c | 184 +++++++++++++++++++++++
> > >  1 file changed, 184 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > index beae06c9c899..0efdb1009175 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -9,6 +9,12 @@
> > >  #include <sys/stat.h>
> > >  #include <sys/types.h>
> > >  #include <unistd.h>
> > > +#include <sys/socket.h>
> > > +#include <sys/wait.h>
> > > +#include <arpa/inet.h>
> > > +#include <netinet/in.h>
> > > +#include <netdb.h>
> > > +#include <errno.h>
> > >  
> > >  #include "../kselftest.h"
> > >  #include "cgroup_util.h"
> > > @@ -772,6 +778,183 @@ static int test_memcg_oom_events(const char *root)
> > >  	return ret;
> > >  }
> > >  
> > > +struct tcp_server_args {
> > > +	unsigned short port;
> > > +	int ctl[2];
> > > +};
> > > +
> > > +static int tcp_server(const char *cgroup, void *arg)
> > > +{
> > > +	struct tcp_server_args *srv_args = arg;
> > > +	struct sockaddr_in6 saddr = { 0 };
> > > +	socklen_t slen = sizeof(saddr);
> > > +	int sk, client_sk, ctl_fd, yes = 1, ret = -1;
> > > +
> > > +	close(srv_args->ctl[0]);
> > > +	ctl_fd = srv_args->ctl[1];
> > > +
> > > +	saddr.sin6_family = AF_INET6;
> > > +	saddr.sin6_addr = in6addr_any;
> > > +	saddr.sin6_port = htons(srv_args->port);
> > > +
> > > +	sk = socket(AF_INET6, SOCK_STREAM, 0);
> > > +	if (sk < 0)
> > > +		return ret;
> > > +
> > > +	if (setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0)
> > > +		goto cleanup;
> > > +
> > > +	if (bind(sk, (struct sockaddr *)&saddr, slen)) {
> > > +		write(ctl_fd, &errno, sizeof(errno));
> > > +		goto cleanup;
> > > +	}
> > > +
> > > +	if (listen(sk, 1))
> > > +		goto cleanup;
> > > +
> > > +	ret = 0;
> > > +	if (write(ctl_fd, &ret, sizeof(ret)) != sizeof(ret)) {
> > > +		ret = -1;
> > > +		goto cleanup;
> > > +	}
> > > +
> > > +	client_sk = accept(sk, NULL, NULL);
> > > +	if (client_sk < 0)
> > > +		goto cleanup;
> > > +
> > > +	ret = -1;
> > > +	for (;;) {
> > > +		uint8_t buf[0x100000];
> > > +
> > > +		if (write(client_sk, buf, sizeof(buf)) <= 0) {
> > > +			if (errno == ECONNRESET)
> > > +				ret = 0;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	close(client_sk);
> > > +
> > > +cleanup:
> > > +	close(sk);
> > > +	return ret;
> > > +}
> > > +
> > > +static int tcp_client(const char *cgroup, unsigned short port)
> > > +{
> > > +	const char server[] = "localhost";
> > > +	struct addrinfo *ai;
> > > +	char servport[6];
> > > +	int retries = 0x10; /* nice round number */
> > > +	int sk, ret;
> > > +
> > > +	snprintf(servport, sizeof(servport), "%hd", port);
> > > +	ret = getaddrinfo(server, servport, NULL, &ai);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	sk = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> > > +	if (sk < 0)
> > > +		goto free_ainfo;
> > > +
> > > +	ret = connect(sk, ai->ai_addr, ai->ai_addrlen);
> > > +	if (ret < 0)
> > > +		goto close_sk;
> > > +
> > > +	ret = KSFT_FAIL;
> > > +	while (retries--) {
> > > +		uint8_t buf[0x100000];
> > > +		long current, sock;
> > > +
> > > +		if (read(sk, buf, sizeof(buf)) <= 0)
> > > +			goto close_sk;
> > > +
> > > +		current = cg_read_long(cgroup, "memory.current");
> > > +		if (current < 0)
> > > +			goto close_sk;
> > > +
> > > +		sock = cg_read_key_long(cgroup, "memory.stat", "sock ");
> > > +		if (sock < 0)
> > > +			goto close_sk;
> > > +
> > > +		if (values_close(current, sock, 3)) {
> > > +			ret = KSFT_PASS;
> > > +			break;
> > > +		}
> > 
> > The test is flapping (at least on my dev machine) because of this condition.
> > 
> > I believe it's because of the batching we're using on the page charge path.
> > So, in theory, it should be possible to calculate the maximum difference
> > like num_cpus * PAGE_SIZE * batch_size.
> 
> I afraid it's more complex and timing sensitive
>  
> > Alternatively, just bump allowed error percentage :)
> 
> so I'll bump the error percentage :)

Ok.
Please, add then a check that current >= sock.
It should be always true, right?

>  
> > > +	}
> > > +
> > > +close_sk:
> > > +	close(sk);
> > 
> > It would be great to check that sock and current are getting 0 values
> > after we're closing the socket.
>  
> Hmm, here it's also timing sensitive. I can see that sock is reliably
> getting 0 if I check it after the server exits. But current usually remains
> small but still !0.

Ok, then I'd check that sock == 0 and current >= 0.
That will catch some refcounter underrun issues we had in the past.

Other than that (and assuming the test isn't flapping):
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
