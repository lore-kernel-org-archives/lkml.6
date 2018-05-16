Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeEPOEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:04:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39508 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751389AbeEPOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:04:28 -0400
Date: Wed, 16 May 2018 15:04:08 +0100
From: Roman Gushchin <guro@fb.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: cgroup: memcontrol: add basic test for socket
 accounting
Message-ID: <20180516140332.GA19754@castle.DHCP.thefacebook.com>
References: <1526470089-27010-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1526470089-27010-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:67ad]
X-ClientProxiedBy: AM6PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::35) To BL2PR15MB1075.namprd15.prod.outlook.com
 (2603:10b6:201:17::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;3:qv8J1Neqyta9595EEB+5ytCUugdGBWkYDumo9h6Vd5iUQN0aq0Ntnd6wi08ZbwDLrOq/xnD00iiPDCl9vT+ojkbhqKOG+JsZqf4ZFADXf9dqFrCC+7W7X0uKu3NUX8xVKNpQdBfKV4AF7mEaalce0uUc8/ZB3WcJBF+HScXwAI72KyZKiTAYaQIhh9z69vyHBjcDSKCgHwrx3F1eKoI7bB5h7l/WsnlOgAbxivs379RQ4s0WfC1Wk1NWXqgC7BmF;25:8j7b8ypMTtyNPQkM1h0yj7xb1V3j9KoSedJCGo8LxeTyHvfPtwkEUhck3C5sCvQHsrPDjsxow36J8/98GVSdvR/MfQtYbInrogfzpihDCyrQX1+QD7HHFkJPXPg3W3DBsWDhnVFzeCAxqKEjVIsH5jZy5NPPKAgVLw0UoznoLezSxpPPzSTitXloDjtXHJqRwJznljU8SO9NbAx8AcLz3bnwV1zSiavKv35DRdearJyyLXQPg83Kf+XWtQkaL7AGR/BEsWSvH5/KYm04Ca/insUrqAhuHtD5SwbcfBYjxZGuJMMSti1SQV4UX5IqX7j7/Cg15hipJQcIgAl9EDA/AQ==;31:sk1dj4QWCZ1x4NXSqHX5DKUlyOn2yS2WjZAmuTOXOjTY1a7TgD5gE0KoAWVumj0cUMErQli9/gcWGmlueyXSYke7qZ5nkLQ6udTWFewY7Nc5Z26TIEUlVZ3WTJT03WxiL5B2D7glx1RPoUOw6BOxRp7D3kxexUuE4jmsu+vQgFiqKKRg8XbOmhstp+97R69bm1nJO0GuQohQDQPspJlW6HzNgg6068106rflyheiWzQ=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1075:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:z9AEV12oc8CbqctOl8Uya4msyqk09UZkDy2ZymfssJ7zMqQi+F3UzXlHHIWdJcw3la5AaGfFA9QYYE+F2Pdy5WqPO9E0rQefQ4kId+EAmb5jLqZDWvH1fZIL1MJndCfCkuugnpTtCKLuCXoYVn5ThRZcGTla5WEkStmb57e0ZYUKnhwo3tv3nag2THYtjiAtEV3Jgl4lXFsHISQvs4oZGKdAKXvSYHBWKNlGiZ+s1q6qm2fQVEZew1Pr93ErQRQC9ob4XJR21bhaXHeT9Lv+PdEDBilel1xc0VICjCMKEqcrFr7Nu5ie2sMhvcCgLVTOE1JZhYdFEHhvk+dEPwjpsyCkGLnx/r6VIEAHFd3jHYFQkOnD+OmKLpsGTwzYrXHPujw8ctUoZFhJDt9HDApSDHS90QqpkPfuoJmWHVBpFiolCQ3CaGiQ3etoA79m+3OuxdRo0pN2LAxq9LO8aJ7HgMf91BRqmnRykJsUW/xU2EPgvSaABFQC7EtOo+kokr52;4:OxJIBNkdb8QAGpTklQi/qYw3cjhQJxNfWCdXC1MXylZ+ai9fW56SgYixr8IkdtGiJ7rGEYGx535hTsk3vppO46pRSTPqoyb9GZ78BPGxM9coyGUBkSwkOvu16JB5fcmRZGq49dpa3StmdoeZMHRVOgBQA4PJPZZxSlLMUwapGagJn9+pkP+DJi0aDFWILXhafoxR2Bjnb+N/cdROxL/F3pqhyAhABRosIoQ99aUTYqjqBxtcKNhH5ncKmX3FlsTOpHsSi7TPzdAVGsdi7X+LGHb+7yOnjdtoqYlbL/Lv+NdJUm+PI2ZHwLCaYO2JZ/c4oiOeao1PbXCOZeBDUlppfw8YgkyVhPuZpNS+jJty48/7qiIO5BfjPjGLHb1CJVNEX/8HSEeVCs7+iCTstjYVXHpx8nSn0YnnUIFAB6DUUy8=
X-Microsoft-Antispam-PRVS: <BL2PR15MB10752A04F639431DBD0B121CBE920@BL2PR15MB1075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(265634631926514)(104084551191319)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1075;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(199004)(189003)(6506007)(386003)(229853002)(16526019)(68736007)(186003)(76176011)(86362001)(478600001)(59450400001)(50466002)(7736002)(6666003)(8676002)(81166006)(81156014)(105586002)(6916009)(5660300001)(106356001)(8936002)(7696005)(52116002)(305945005)(55016002)(33656002)(16586007)(9686003)(53936002)(52396003)(316002)(2906002)(46003)(1076002)(4326008)(54906003)(6246003)(23726003)(6116002)(58126008)(446003)(47776003)(486006)(11346002)(476003)(25786009)(97736004)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1075;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1075;23:YR6n0sH5NUvBJOpEXBzj5BFqS/fsgqJSZ4IWoBG52?=
 =?us-ascii?Q?+ZEOjOZWTNr9fvbHXxlVWNNFtHXW5vBjWPrOkKNNEtV0FzAXaGiYgqbzAMdk?=
 =?us-ascii?Q?WnxoNapyh8VItnWREXewbtUdhXiaGZSH2hfJm80jquo8LaNIlnYwKqMM8DG8?=
 =?us-ascii?Q?SUXTvdzoL89bC1rvopTIEGNppKDOpvSFPMPjoXXW+SH1gDT0GwEQaJTCvh94?=
 =?us-ascii?Q?pPsHU4Nq9TdxkvefVd+2U4iPPqFlMM0z9DF9sYU2ZGolf/qqLPBnaadl+xDY?=
 =?us-ascii?Q?oX0jQPpss9AkLMX7ym680sj6AJgWh+vrkqIj67Qs1yUQwgl+gSpDUqE+n3Tv?=
 =?us-ascii?Q?FrqTOc+gKmCAlly83UMqlNOQn5Bw0wnsVJgWCjZN8go4CPGUbvkVHU+w4/bQ?=
 =?us-ascii?Q?UBfsY88ROf9m73F+PbDIRJwCnlnX0ZG+qOIPXuN274pJYxT19QAAeRm+xqzQ?=
 =?us-ascii?Q?QJfMRRbHoIZrMfhOxUHpR2n7WfDsInv2jM2C4k0Y9ZKFpmXMTKnsNAExQ0Fz?=
 =?us-ascii?Q?pyNrasHLKCjb6GEjKFg71/Z3Z9mMrSSzHrXP3ImXwbwtv6iIFDL69ZVHgMoY?=
 =?us-ascii?Q?1ExloxOxvvMVSjS07z9LoB4HeOzSMIZoIzkk6FlytPeq/gqn8llcNJv0QfnD?=
 =?us-ascii?Q?f1FixSVwaomGRgtIAcRzR7LjaVCVfgxXIPor8dU8HwVgEm/Bm0jekrPNQCNH?=
 =?us-ascii?Q?1/Mhy2TV/tH662KqnVVYU62Ua0FjM5iXV+piLB7e7aYqhL5FFKVCLt7tI9LS?=
 =?us-ascii?Q?wqL1RBxxVzTNerw6J3dlGxu/tOd/aGDeUorOxrLoPpLLWUX5/pqOviANt8hX?=
 =?us-ascii?Q?SiamMqjQLbkdIu471gwGtkgBLzrOZ3oMMR6sLvjjF4ITgySt/Tx71NNkqFQG?=
 =?us-ascii?Q?Ht0stFf+S/T70ve/TPdLHiQxTmwoqiquhF89vahawFUzz0Gv4Fa2ZR1Fg3GB?=
 =?us-ascii?Q?i9WxGvhQsVEl/azkWTHkfVIClkS68GAhZ5XCLrKngfxr2tk1k8mqEgJyT5/S?=
 =?us-ascii?Q?fE6TdSFPkCPcm0R/VD/mqdYftkMt9Up0EhdH80vKGrV441wFWv5jdcOWT3QI?=
 =?us-ascii?Q?V3zgoQgkxLMHaPYJ2CTz3Yq7MfLfeiHNNE8ttHtBmYLwHZiOhvQwrh2u5XNd?=
 =?us-ascii?Q?hYWrxE7AoFt6EZJJT5/emF8R/w1DNZgkcsZIETJddAy69E53XL6JTgrwQzGn?=
 =?us-ascii?Q?ARcjzILm1bN1sM2Ey0XFw3DslQK+MClNYRvaif+Qhin+xC6gPGT6vUtLdQhQ?=
 =?us-ascii?Q?vjczo+cPt73yFN1Do8dDRmgzEYJ3FVlzzY4KXJ3?=
X-Microsoft-Antispam-Message-Info: hvL2R0kioObsT5H5wxYAqnXL2eDt5GaPSV1Rqq0bDQb/awegTxs/cCEXK41MgbOqOyf/KeBWSlTU8QzW05C2kcvhLYuZBjjRaTMek0WjXwioX91AmN1+bW79sAxX1YNOy2UfBH9fuLVCf7ya85TV2+SI2bzW7JDHO8D0VZ1UlAswUNm2z9TZw2qYjzFTroAz
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;6:yjEDrPpkvwwVJ4enLbRJSn6ToF0ODPwsSekTlJRGTASivuchXZNdx5TE9LUW/IXLjm6vrD8lu/eIegePXTEdSpX+5M7xRegNE/0PBsuQ9LbIZM9zJ7a4fmsQfGzpDa2k7+1joHdz7+0hFXpBoVzhZjUbQSsinPFgBgsjx47qwepxyCBlOQts2pS5j5p5D/PdPmBt176mMPWGC+ZQa/g62SgUEibaJYr9PremHFO1NvvxM3/s4ZtcOfnmuLMScfa7xLITFBWkX4H/xo6f5fPF7APz0q5O1q3mAwtDcOvnKmUq9P6d6XxPkqhobRlkqPPkkDjeAhzMqyW1biVwjrIdkK+zq8toSCE6oE5/AazVAN7z3AqLD1keTiCJu5XFBwLWCftlovMPpOyWVdR+g6oK4uoCbPubyo6az2eG9Z87hSrAv4gIpR/Cjdk7S8+2Itx2hezckzgw8cpQKcI9XAhs7g==;5:DZtcAsTTn/Y05PndYTD9K5Bw4QwostTlLaDNHmOqt2ohLcSedp8IvDR6J39eTpR8Z6WILTi5vtBTBhFd/niQsz62Q0Wsg10CZoqmmoUnhBoOkHw8c717eZElpL8bYnsHjm4SBXOVw0COk0rMEpxnnLBgU1MLR+Jk8NfAFFbOtko=;24:BDdUxnAwE4VbJDMIpI1IlBrlZ+KMkn+lAcxFnwrrOKEzSTwFkUbXOxxUJeyVpCZRvzXiDmaBtwpm6okl3vFTlMJOfn1gFXWPOjHeJE44Wsk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;7:kGzALcEg9DPpJBOBqgz81gG9IOug8mAhXASadPhvmkIe3RP2Xc8HDklL5FHAJU216D0IxKMLUbnjWPhvlAjAlXV+UUKwIGD+LGnvqLxDpD32PxiGY0eYTF42e4QbDUIkf3zg5sLDqQz660lj+uANsecKyJ74Km9G1MTFO+ARWFAu0jz04DpDD0c7Vvcp9oPWZRh+V8se4a+u5rl6C7H/ZqoSYyLpEE/OWRRpYr1lrAjChPvkv3evYIqCF/WOIloR;20:qmUdp4eQ0cNulabEU7iNH6Hd784n6GsVhQucQu5PE0T4xsGuneuR+Ca/1VYljmgFPQduAaK3IEXwSKNf5WRp7FajONE9/ynlFoJUJtPGIBrbCRfUY0PHmOwT4c9WSc5qLcazSvJe+7/3YMviYgby9+QU5LT8HerV0bVCb7t3qMk=
X-MS-Office365-Filtering-Correlation-Id: f8097e56-290c-430f-ac41-08d5bb35eb0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 14:04:18.6619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8097e56-290c-430f-ac41-08d5bb35eb0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike!

On Wed, May 16, 2018 at 02:28:09PM +0300, Mike Rapoport wrote:
> The test verifies that with active TCP traffic memory.current and
> memory.stat.sock have similar values.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 184 +++++++++++++++++++++++
>  1 file changed, 184 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index beae06c9c899..0efdb1009175 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -9,6 +9,12 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> +#include <sys/socket.h>
> +#include <sys/wait.h>
> +#include <arpa/inet.h>
> +#include <netinet/in.h>
> +#include <netdb.h>
> +#include <errno.h>
>  
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
> @@ -772,6 +778,183 @@ static int test_memcg_oom_events(const char *root)
>  	return ret;
>  }
>  
> +struct tcp_server_args {
> +	unsigned short port;
> +	int ctl[2];
> +};
> +
> +static int tcp_server(const char *cgroup, void *arg)
> +{
> +	struct tcp_server_args *srv_args = arg;
> +	struct sockaddr_in6 saddr = { 0 };
> +	socklen_t slen = sizeof(saddr);
> +	int sk, client_sk, ctl_fd, yes = 1, ret = -1;
> +
> +	close(srv_args->ctl[0]);
> +	ctl_fd = srv_args->ctl[1];
> +
> +	saddr.sin6_family = AF_INET6;
> +	saddr.sin6_addr = in6addr_any;
> +	saddr.sin6_port = htons(srv_args->port);
> +
> +	sk = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (sk < 0)
> +		return ret;
> +
> +	if (setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0)
> +		goto cleanup;
> +
> +	if (bind(sk, (struct sockaddr *)&saddr, slen)) {
> +		write(ctl_fd, &errno, sizeof(errno));
> +		goto cleanup;
> +	}
> +
> +	if (listen(sk, 1))
> +		goto cleanup;
> +
> +	ret = 0;
> +	if (write(ctl_fd, &ret, sizeof(ret)) != sizeof(ret)) {
> +		ret = -1;
> +		goto cleanup;
> +	}
> +
> +	client_sk = accept(sk, NULL, NULL);
> +	if (client_sk < 0)
> +		goto cleanup;
> +
> +	ret = -1;
> +	for (;;) {
> +		uint8_t buf[0x100000];
> +
> +		if (write(client_sk, buf, sizeof(buf)) <= 0) {
> +			if (errno == ECONNRESET)
> +				ret = 0;
> +			break;
> +		}
> +	}
> +
> +	close(client_sk);
> +
> +cleanup:
> +	close(sk);
> +	return ret;
> +}
> +
> +static int tcp_client(const char *cgroup, unsigned short port)
> +{
> +	const char server[] = "localhost";
> +	struct addrinfo *ai;
> +	char servport[6];
> +	int retries = 0x10; /* nice round number */
> +	int sk, ret;
> +
> +	snprintf(servport, sizeof(servport), "%hd", port);
> +	ret = getaddrinfo(server, servport, NULL, &ai);
> +	if (ret)
> +		return ret;
> +
> +	sk = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> +	if (sk < 0)
> +		goto free_ainfo;
> +
> +	ret = connect(sk, ai->ai_addr, ai->ai_addrlen);
> +	if (ret < 0)
> +		goto close_sk;
> +
> +	ret = KSFT_FAIL;
> +	while (retries--) {
> +		uint8_t buf[0x100000];
> +		long current, sock;
> +
> +		if (read(sk, buf, sizeof(buf)) <= 0)
> +			goto close_sk;
> +
> +		current = cg_read_long(cgroup, "memory.current");
> +		if (current < 0)
> +			goto close_sk;
> +
> +		sock = cg_read_key_long(cgroup, "memory.stat", "sock ");
> +		if (sock < 0)
> +			goto close_sk;
> +
> +		if (values_close(current, sock, 3)) {
> +			ret = KSFT_PASS;
> +			break;
> +		}

The test is flapping (at least on my dev machine) because of this condition.

I believe it's because of the batching we're using on the page charge path.
So, in theory, it should be possible to calculate the maximum difference
like num_cpus * PAGE_SIZE * batch_size.

Alternatively, just bump allowed error percentage :)

> +	}
> +
> +close_sk:
> +	close(sk);

It would be great to check that sock and current are getting 0 values
after we're closing the socket.


Thanks!
