Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeC0PHy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:07:54 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:5369
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752152AbeC0PHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 0/7] net: thunderx: implement DMAC filtering support
Date: Tue, 27 Mar 2018 08:07:29 -0700
Message-Id: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:3:93::13) To CY4PR07MB2998.namprd07.prod.outlook.com
 (2603:10b6:903:d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4303e70-70ae-4cbd-a323-08d593f47fe7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:MvzIKZ1wl/7K5+bYDeeZplsVmiiqRHZvWZruFQ9vYVRvmwu3MkLrz+DZYruEx1hnlIeqXRz/LxCqHEDBlI4N2U/bHVLo22Bna8I+FfmUtKrrdEBkcc399+y/+1n1lE2JoCqMTsBt2/gRAgV5rRCUUpcsZwnzBPfLEPYSy1HVJQo956ceFVwd8iWKcGYhVpGUdBGNPKef+pP55EgVUlaFJAvgZzS5NrnFNsQw2e8F/w1pXATDDYbdOdJUTYfJzcWk;25:m0yF4nVFeNQiUHgg5TYIsxhYfMtsT9wwpF2w0ZjbGBBvRHr0DQDfg0f4rDpFQ0iIi8gy5DnsDalmi1aShR2FSchpXXriyi1oMqt+AB0bU0IFLIW3qWmVAsrXA2xVD2aW8gLI+nRD9Dw5HzEVyB7JS/hGCtvmVH15ioLq3frGLNh4hrNvundnDUfg/T82TtJvABPnVRMFI97duWxgEYZOaFvAhRbEC98tKHOr6TZDPyzxpH93EW+CRjnKn4gqPM8Tm89GwacG5uaLFHiq5XKPIPAsHTYAN3MhAUCXL7OpFpjf//NW/M4+/oFrq4lHQtSdmtd41hAvluk/l9bD7ajJXQ==;31:U8feielnJtXnpzPBbU/zarHNyMfQyXg6K8+T7IKRTtiLbyXxwh0n5LaHUS++QOS3Lu3gCCSl4vqZmwRhvPHSqq+hyWve0hx97Awzz7NkolcgXgND3OAeRUe8aQt6kCaMixp1PO1Hv0tT8RWRWtqnyS23KXg1+qGLxLG1/JzbfCCLOSkdYleFnt4TtWF10TnbfSrzWBT0sG94H85vC9BarsmI2PQ2aYmlfXMVqOYqY/s=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:JC+jBA436nwlJfJaukVwxpWa/gAGjWVWFeXL8DidBSP1GirMCM71ZWV/ydMHXH7H/VXKQQbJ0iAAL6eKnOeiCWyPdrcuau7ECRUuYcEumXG9QuqlEt2LPiqgAuNSfW3bQmyRyr9rnp4qMFw5TcisC9xIrwGPVw4+gnbpL5rXOQgfJhsXYs+epUIAfInQySt9j6mlxGC2exZA21/FA3RGTiG/MxI5/SC3E/DY+T8t6+Ho4/Cv+ZIGqBwkEtgCcEB+Lo0gBld9Yrh0/xCRdyeegyLoA59pjiF5yA8sKEZMaOLu/m5elhBn/m99AlSu9BqWK5fOZ+Abo3Fn8AQ/cs+zedmTHyqmNux4E5sd3H5yQR4EC7iYetsaMhWG15iBQ8k5g5GKf7CMUs4x57eJIRyxZ1pxvT9eH4vVFBL49efiJ/FCT74SRpLpk2bA3IWBAD1mgKKHD/Xy4GFproOXiL6xTgrkrmrsWyiidTqMucg707DG3YlxLdJn+nG8r9HintBrNQDkAUhRfXp3p6kATBLrY62F9qNjuuLikduLun0xOO9tC/wk7CRyeiasoo6Pe1/kcFwTLVZbL/DhMFkNCp1sHm+0hLpQd3M70heU23a1GTo=;4:YB7gKcwiyvex9V0EKGHF7vXxfovjUe3NUlqIbDUKXDAzm2UDy6D0+BNev7bvP6Vx/gyABg+anzat3Qd7Z8TK69BaUUJIsPubmeupxBsGcK+JEPbUqqxPKTmmqeG2A9CyDkaXLOJGTrdKy1PjhXopt82TJcTttc34dhwzdDsmXOcZzBOv68CG65gKR28+m0pzzVemwkY21hsvPb8ORys5Lm3zvvQI+kc6tvDq8QbDhY3MJZlbkrw2jRFc+3L6aUSImCJQwRmKxg6+cHOTLA9oyQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB299878EA3D89F1934B1646408AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(486005)(486005)(6486002)(6512007)(316002)(305945005)(105586002)(42882007)(6506007)(386003)(68736007)(59450400001)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(81166006)(8676002)(36756003)(476003)(2870700001)(50226002)(4326008)(5660300001)(81156014)(23676004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIyOTk4OzIzOmNpYndlMzFrTlFTa09kekFqbkdBSVQrMHFE?=
 =?utf-8?B?aFdBVDcwcXhXVE8ycnZiNWh0cm5TZjNHTnhDWk9UaWRYaVlZZEFYcFFEM0or?=
 =?utf-8?B?Qk5WWmUzQU1MOGdWNWdNRmdHbEhnVng2U3FuVk5kNmhaNk0yazBjTmxjUEkz?=
 =?utf-8?B?NkVlYVZDUkFuNFBIb3U5UmtCYm92VGJLc21uT1d3SmFtVFdGNmdjbGxYL2ps?=
 =?utf-8?B?M3B3VDJrZFZ1VWhRRXVaTFRjbjVmYVczMDNRMy85Y0JzckhmMkNqSDVJT2dp?=
 =?utf-8?B?ZUhwRCtaSWdFb1RrdENWTitnc1gvNEZLWFVZclBoVTNEUTJWNER2aUt6ZEJv?=
 =?utf-8?B?WjhMZGwwRkZZSmFmazJlclZnM3ZmUGdEdjd4U3RRTTZma0VuWVNQRDV3MG9L?=
 =?utf-8?B?WjBzUThkYmtFMUhQSmw1NGROQmYyZEp2bmVRUW1nTnJURUoxaG5YL012b2Ny?=
 =?utf-8?B?dEhnY1lJdCtab0U4NkwzVktEWjM0dlZhRXNxSlJ4UGNQTGNjMG50ZEcxUmJk?=
 =?utf-8?B?R0loT3JGREdUeDBBWC91K1QyYTZuaEtaQSs0bmdRWXA3TUxSdmtDNHZWNFFS?=
 =?utf-8?B?a2xSaW93bE10VU1XMU9JNG84aVFGdHJFWjVVaDlXWVp5ZWpVU2V5N2pZdFlY?=
 =?utf-8?B?VStuaHFDTnR3SDJucU14MGFvZXdnUnNWNlNBdStYNU9ZLzFINEY2aVhxSElO?=
 =?utf-8?B?ZFhaTEVHSWVkRDFVaXNJWWVzQ2JMZjJ0RHFWN21SemdYMjVxNDF6VnJZT2N5?=
 =?utf-8?B?YWREbzBvdjdlNUZMSnpHNHFaREZ5ZlNnOXFOdzIwbUZ3Rm9qMlUzY2NUcjNl?=
 =?utf-8?B?TzJSMzQ2d2VOa0VpaVcyM29aSm1Fd1k0b0pzbVdQemRyMG1aMkFpV240YjFB?=
 =?utf-8?B?Y1dSY3B2NVJuZC9tbGdycEFMdkluQWxIUUh5TXlBWlllYzdvcFZiUENQSkRu?=
 =?utf-8?B?UmtLVmk4dmU5ZzFoQmlZbjRqeTVoVERCY01aQ056T0JlMXljTDFLUmlqK3Z3?=
 =?utf-8?B?bUdqUWVWSm5Oc0thSTZBMjI5aUVwa0Q1WmJCV29GY0dZQjhDTndOVUNGT1pl?=
 =?utf-8?B?R0RCc1RYUjJCQmhQZVpFVElhZUFVTjIvc3c5QVZOeFFESi9pYnRyMDF4cDJE?=
 =?utf-8?B?MElpZCt5TEtDYVBvSlZidkFaRjdtdk5lWWZBczNtZXF4RUVObk5qM2tXS01G?=
 =?utf-8?B?MWk1SDJuYkF6NVB0WHZ3cW9YVlF2Tm1MTndXcHF1cUNaemZocmVYNnlwNVU2?=
 =?utf-8?B?U3JuTml6RHkyaUYzcENFb2FnVUNEWjBSTUxkd0hKNmhhVFYyQ3ZYMUlIckpC?=
 =?utf-8?B?Y1BUeVM0N1lTcEFUaVVDc2lVUXpPSUdaejEvQVhQK25oWStDeElCR0swaHM1?=
 =?utf-8?B?cjhXa3pFNFY3UFRwNS9IRVhtV0pLZFp3UGkzSkZ6OWlWTWtjU2hoQ0VQOFdz?=
 =?utf-8?B?QkZaY0RNMGQxYWhDVlRPSi9nLzFBQzRqaHh0VWd3ZnVRTXoxTENsMVg4TVpw?=
 =?utf-8?B?dTRoR2taanpIM3lseEF4REVtVGdaaDZQMTRBV3dWRlVyRzJxUWdKSFpvRnky?=
 =?utf-8?B?WGZTUEppaGVQeG9WRGtXZTA2YUwyeUQrWURtZlVnQ0tOa2FqY1FYMUcyQjMx?=
 =?utf-8?B?RUZLWnlBUHIxVEtZV3NYY0hOc0dJeEdHS2xqVTdYRWhuWGYrS3FYOVlrY3lr?=
 =?utf-8?Q?amB0XewWg3SQ/eAC6zzZCmgRms/EeGXq0hS8hzr?=
X-Microsoft-Antispam-Message-Info: epMPOrFKsvuNEoVmlFyZGKl1gUwnOsimzT8pAjXgUvReGU9fQJEqwiJJqCgnN+pFeMQJRnPYY7+yYz77Z0VFVE5n66MUMsQiyxijN+8nYAdgZOWZrj606vL5am5MZeuX01RE8/50t2wQHx4NJ6jXIGdYOW3B/XjzvkTh4foygxfF/dn0vvF4JfhzWSrZx/ma
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:fsrFskL01DnS8K1eKBr+dwjb4ye+GPdbztfaUQUtKpyixvYo2KYo2OCGjgWUSVgH4H3nnmUzJTQHmM0UXc3ps2T5Gk2PGZDW4OPOkIcLFOle0LtdP7o91d9hqcVflYW8YOHsEPniHz2Q7vok+D/JIVrYSYAGBeI5jcbEytDZe9SLs6SzceTL2AjVO6RxCb/GZxO8XkWASLBrdlomAqF8io2CKAWP6uQGujDPCPkwWpGhM1kHliJlLTVK/CWmm48E4yQRyyLVFoXX2R90k1uVgrrGK9m8Rh2EkOx9k8GWdFxsoUouMJv0ufGnmtn5JgIAXC4TDAJpvlVy3ooyx78mO2twpycHUOlnIsUn2k+1jgKIgp2Gt5VJfthY0tV0PZ+Lfos9wnzlC8XucaWPErEeMfi1H+XyYBhMM08M1prjxrh2Ve3417oszdcsQBg6xedYWwiwUIh7diFOwd2p4j21zg==;5:6H0dMh/GK8RZz3+K8lXjBqrnV2SqXiVboMqISJjMkUauRBcJ/gBtCdYHUa4Tlm88tAwjI/aMogzFZ+9IEDE6R/Xx+BwDwy3t3A2FMQWy8JYRlFaJrRLLLIifWQZT6CQtZWOS/PoqqkCQVOgpyAofjGUT7dPuQLQi2dCjtl+x8pk=;24:7GGdJATw5VHPOPTApHj45ncmvWpGNYBwpz3L/KvH7QlFNcFAqVTCiSvKviMCQhiyBk0edqfRZ/s+tVYiA6u/jVvnwwAU/mM6lovpV2vlYhA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:uAB1VoXBZDS2QWAu7q6jIREIZ3OzRD0sj2KMbemUNXpT9/qFokeAfsBW9XAelbEMl0E4Nt+50+ZFmG1WBhfjbjzpTcZ3kKNJwkzOm7engXsRJxbpN0QLXbiBAF+XaM+m4xNHM6O6Qfsn478UiWSv+3iJEApjqtjed/GN1BX2iF4nrJ96kjWK+bbd/N28M9NYqWQnMdv/zmEBhrPwXNm//3kpHyS/67K1VgSNm7+rmWvP4X9iZymZ8gk9jj4nZ+bX
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:46.3733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4303e70-70ae-4cbd-a323-08d593f47fe7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

By default CN88XX BGX accepts all incoming multicast and broadcast
packets and filtering is disabled. The nic driver doesn't provide
an ability to change such behaviour.

This series is to implement DMAC filtering management for CN88XX
nic driver allowing user to enable/disable filtering and configure
specific MAC addresses to filter traffic.

Vadim Lomovtsev (7):
  net: thunderx: move filter register related macro into proper place
  net: thunderx: add MAC address filter tracking for LMAC
  net: thunderx: add multicast filter management support
  net: thunderx: add new messages for handle ndo_set_rx_mode callback
  net: thunderx: add XCAST messages handlers for PF
  net: thunderx: add workqueue control structures for handle
    ndo_set_rx_mode request
  net: thunderx: add ndo_set_rx_mode callback implementation for VF

 drivers/net/ethernet/cavium/thunder/nic.h         |  29 ++++
 drivers/net/ethernet/cavium/thunder/nic_main.c    |  45 ++++-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c  | 108 +++++++++++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 196 ++++++++++++++++++++--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  17 +-
 5 files changed, 366 insertions(+), 29 deletions(-)

-- 
2.14.3
